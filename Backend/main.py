from flask import Flask, request, jsonify
from flask_cors import CORS  # Import the CORS module
from google.oauth2 import service_account
import fitz  # PyMuPDF
from PIL import Image as PIL_Image
import os
import time
import random
from google.api_core.client_options import ClientOptions
from google.cloud import documentai_v1beta3 as documentai
import vertexai
from vertexai.preview.generative_models import GenerativeModel, Image


app = Flask(__name__)
CORS(app)

PROJECT_ID = "dbsdoccheckteam7"
REGION = "asia-east1"
LOCATION = "us"

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "dbsdoccheckteam7-35ddca73e29c.json"

script_dir = os.path.dirname(os.path.abspath(__file__))
SERVICE_ACCOUNT_FILE = os.path.join(script_dir, 'dbsdoccheckteam7-7b5fc6a831cc.json')

credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE)
vertexai.init(project=PROJECT_ID, location=REGION, credentials=credentials)

# Initialize Document AI client
opts = ClientOptions(api_endpoint=f"{LOCATION}-documentai.googleapis.com")
documentai_client = documentai.DocumentProcessorServiceClient(client_options=opts)

# Define the processor details
processor_id = 'd278cfccbeabce7'  # Replace with your actual processor ID
parent = f"projects/{PROJECT_ID}/locations/{LOCATION}/processors/{processor_id}"

UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
def index():
    return 'Flask backend is running'

# Function to convert PDF to image
def convert_pdf_to_image(pdf_path, image_path):
    pdf_doc = fitz.open(pdf_path)
    page = pdf_doc.load_page(0)  # Get the first page
    pix = page.get_pixmap()  # Render page to an image
    pix.save(image_path)

# Function to generate content with retries and exponential backoff
def generate_content_with_backoff(prompt, image, retries=10):
    generative_multimodal_model = GenerativeModel("gemini-1.5-pro-001")
    for i in range(retries):
        try:
            response = generative_multimodal_model.generate_content([prompt, image])
            return response
        except Exception as e:
            if "429" in str(e):
                wait_time = (2 ** i) + random.uniform(0, 1)
                print(f"Rate limit exceeded. Retrying in {wait_time:.2f} seconds...")
                time.sleep(wait_time)
            else:
                raise e
    raise Exception("Maximum retries exceeded")

# Function to extract labeled data from Document AI response (change this accordingly after modifying and making the processor)
def extract_labeled_data(document):
    extracted_data = {
        "Name": None,
        "Date of Birth": None,
        "Passport Number": None,
        "Date of Expiry": None,
    }
    
    # Loop through document entities to extract labeled data
    for entity in document.entities:
        print(f"Entity type: {entity.type_}, Mention Text: {entity.mention_text}")  # Debugging line
        if entity.type_ == "Name":
            extracted_data["Name"] = entity.mention_text
        elif entity.type_ == "Date_Of_Birth":
            extracted_data["Date of Birth"] = entity.mention_text
        elif entity.type_ == "Passport_No":
            extracted_data["Passport Number"] = entity.mention_text
        elif entity.type_ == "Date_Of_Expiry":
            extracted_data["Date of Expiry"] = entity.mention_text
            
    return extracted_data

# Function to process image with Document AI
def process_image_with_documentai(file_path):
    _, file_extension = os.path.splitext(file_path)
    if file_extension.lower() == '.pdf':
        mime_type = "application/pdf"
    elif file_extension.lower() == '.png':
        mime_type = "image/png"
    elif file_extension.lower() == '.jpg' or file_extension.lower() == '.jpeg':
        mime_type = "image/jpeg"
    else:
        raise ValueError("Unsupported file type")

    # Read the file into memory
    with open(file_path, "rb") as image:
        image_content = image.read()

    # Load binary data and configure the process request
    raw_document = documentai.RawDocument(content=image_content, mime_type=mime_type)
    request = documentai.ProcessRequest(name=parent, raw_document=raw_document)

    # Process the document and extract labeled data
    result = documentai_client.process_document(request=request)
    extracted_data = extract_labeled_data(result.document)
    
    return extracted_data

# Function to process image with prompts for generative model and Document AI
def process_image_with_prompts(image_file_path, first_prompt, second_prompts=None, detail_extraction=None):
    if image_file_path.lower().endswith('.pdf'):
        image_path = image_file_path.replace('.pdf', '.png')
        convert_pdf_to_image(image_file_path, image_path)
        image = Image.load_from_file(image_path)
    else:
        image = Image.load_from_file(image_file_path)
    
    # First prompt processing
    response = generate_content_with_backoff(first_prompt, image)
    try:
        first_result = response.candidates[0].content.parts[0].text.strip().lower()
        messages = [f"First Prompt: {first_prompt}\nResponse: {first_result}"]
    except (KeyError, IndexError, AttributeError):
        first_result = 'unknown format'
        messages = [f"First Prompt: {first_prompt}\nResponse: unknown format"]
    
    # Clean up the first result by removing any extraneous characters
    first_result_cleaned = first_result.strip("'\"")

    # Second prompt processing if needed
    if second_prompts and first_result_cleaned in second_prompts:
        second_prompt = second_prompts[first_result_cleaned]
        second_response = generate_content_with_backoff(second_prompt, image)
        try:
            second_result = second_response.candidates[0].content.parts[0].text.strip().lower()
            messages.append(f"Second Prompt: {second_prompt}\nResponse: {second_result}")
        except (KeyError, IndexError, AttributeError):
            second_result = 'unknown format'
            messages.append(f"Second Prompt: {second_prompt}\nResponse: unknown format")
        
        final_result = first_result_cleaned != 'false' and second_result == 'true'
    else:
        final_result = first_result_cleaned == 'true'

    # Detail extraction for autofill using Document AI for OCR
    if detail_extraction:
        extracted_data = process_image_with_documentai(image_file_path)
    else:
        extracted_data = 'not provided'

    return final_result, extracted_data, messages

# Function to handle file upload and processing
def upload_and_process_file(file, first_prompt, second_prompts=None, detail_extraction=None):
    if file is None:
        return jsonify(result=False, message='No file provided'), 400

    if file.filename == '':
        return jsonify(result=False, message='No selected file'), 400

    print(f"Received file: {file.filename}")  # Debugging line

    file_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
    file.save(file_path)
    
    print(f"File saved to: {file_path}")  # Debugging line
    
    # Use Document AI for OCR in the detail extraction is asked 
    final_result, extracted_data, messages = process_image_with_prompts(file_path, first_prompt, second_prompts, detail_extraction)
    
    print(f"Final result: {final_result}, Extracted data: {extracted_data}, Messages: {messages}")  # Debugging line
    
    return jsonify(result=final_result, extracted_data=extracted_data, messages=messages)

@app.route('/upload/passport', methods=['POST'])
def upload_passport():
    print("Processing /upload/passport request")  # Debugging line
    first_prompt = "Is this a passport containing keywords 'Passport','date of issue','date of expiry'? Answer with 'True' or 'False'."
    detail_extraction = "Autofill data extraction."
    return upload_and_process_file(request.files.get('file'), first_prompt, detail_extraction=detail_extraction)

@app.route('/upload/employment_pass', methods=['POST'])
def upload_employment_pass():
    print("Processing /upload/employment_pass request")  # Debugging line
    first_prompt = "Is this an Singapore employment pass? Answer with 'work permit' or 'ltvp' or 'employment pass' or 's pass' or 'personalised employment pass', 'tech. pass', 'international organisation pass', 'overseas and network pass' or 'False'."
    second_prompts = {
        'employment pass': "Does this document contain keywords like 'Employment Pass', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        's pass': "Does this document contain keywords like 'S pass', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'work permit': "Does this document contain keywords like 'Work Permit', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'personalised employment pass': "Does this document contain keywords like 'Personalised Employment Pass', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'ltvp': "Does this document contain keywords like 'Long-Term Visit Pass', 'Immigration and Checkpoints Authority', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'tech. pass': "Does this document contain keywords like 'Tech Pass', 'Ministry of Manpower', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'international organisation pass': "Does this document contain keywords like 'International Organisation Pass', 'Ministry of Manpower', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'overseas and network pass': "Does this document contain keywords like 'Overseas Networks & Expertise Pass', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'."
    }
    return upload_and_process_file(request.files.get('file'), first_prompt, second_prompts)

@app.route('/upload/income_tax', methods=['POST'])
def upload_income_tax():
    print("Processing /upload/income_tax request")  # Debugging line
    first_prompt = "Is this an income tax document containing keywords like Income Tax – Notice of Assessment (Original), INCOME^, DEDUCTIONS, CHARGEABLE INCOME, YEAR OF ASSESSMENT? Answer with 'True' or 'False'."
    return upload_and_process_file(request.files.get('file'), first_prompt)

@app.route('/upload/proof_of_address', methods=['POST'])
def upload_proof_of_address():
    print("Processing /upload/proof_of_address request")  # Debugging line
    first_prompt = "Is this a document that contains a valid Singapore address with a block number and street name (e.g., ‘123 Jurong East St 32’), building name if applicable (e.g., ‘Jurong East Mall’), unit number (e.g., ‘#08-01’), and postal code (6-digit number, e.g., ‘600123’)? Answer with 'True' or 'False'."
    return upload_and_process_file(request.files.get('file'), first_prompt)

@app.route('/upload/payslip', methods=['POST'])
def upload_payslip():
    print("Processing /upload/payslip request")  # Debugging line
    first_prompt = "Is this a payslip containing keywords like cpf, bank? Answer with 'True' or 'False'."
    return upload_and_process_file(request.files.get('file'), first_prompt)




# Chatbot!!!!!!!!
PROJECT_ID = "dbsdoccheckteam7"
REGION = "us-central1"

vertexai.init(project=PROJECT_ID, location=REGION)
model = vertexai.generative_models.GenerativeModel("gemini-1.5-pro-001")

with open('dbsfaq.txt', 'r') as file: #UPDATE dbsfaq.txt for more detailed guideline :P
    faq_content = file.read()

@app.route('/chat', methods=['POST'])
def chat():
    if not request.is_json:
        return jsonify({"error": "Request must be JSON"}), 400
    data = request.get_json()
    user_query = data.get("query")
    if not user_query:
        return jsonify({"error": "Query field is required"}), 400
    
    # Prepare the input prompt with instructions
    prompt = f"""
    The following is a well-structured FAQ about the DBS Credit Card Application Process. 
    Respond to the user's query in a friendly, cheerful and professional tone using the FAQ below.
    Provide the response in HTML format with appropriate headers, bullet points, bold and italic text, and links if needed.
    Use the following CSS classes for styling:
    - <p class="header1"> for main headers
    - <p class="header2"> for secondary headers
    - <p class="paragraph"> for regular text
    - <ul class="list"> for bullet points
    - <li class="list-item"> for list items
    - <a class="link"> for links
    Keep the layout compact with minimal spacing between elements.
    If user query is not in the document, show them the link to the DBS website. Do not use headers here.
    
    FAQ:
    {faq_content} 
    
    User asked: {user_query}
    """
    
    response = model.generate_content(prompt)
    generated_text = response.text
    print(generated_text)
    return jsonify({"answer": generated_text})


if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8080))
    app.run(debug=True, host='0.0.0.0', port=port)
