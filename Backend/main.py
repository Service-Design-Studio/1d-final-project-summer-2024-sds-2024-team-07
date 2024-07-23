from flask import Flask, request, jsonify
import vertexai
from vertexai.preview.generative_models import GenerativeModel, Image
from google.oauth2 import service_account
import fitz  # PyMuPDF
from PIL import Image as PIL_Image
import os
import time
import random

app = Flask(__name__)

PROJECT_ID = "dbsdoccheckteam7"
REGION = "asia-east1"

script_dir = os.path.dirname(os.path.abspath(__file__))
SERVICE_ACCOUNT_FILE = os.path.join(script_dir, 'dbsdoccheckteam7-7b5fc6a831cc.json')

credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE)
vertexai.init(project=PROJECT_ID, location=REGION, credentials=credentials)

UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
def index():
    return 'Flask backend is running'

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

def convert_pdf_to_image(pdf_path, image_path):
    pdf_doc = fitz.open(pdf_path)
    page = pdf_doc.load_page(0) #get the first pg
    pix =  page.get_pixmap() # render pg to an image
    pix.save(image_path)

def process_image_with_prompts(image_file_path, first_prompt, second_prompts=None):
    if image_file_path.lower().endswith('.pdf'):
        image_path = image_file_path.replace('.pdf', '.png')
        convert_pdf_to_image(image_file_path, image_path)
        image = Image.load_from_file(image_path)
    else:  
        image = Image.load_from_file(image_path)
    
    # First attempt
    response = generate_content_with_backoff(first_prompt, image)
    try:
        first_result = response.candidates[0].content.parts[0].text.strip().lower()
        messages = [f"First Prompt: {first_prompt}\nResponse: {first_result}"]
    except (KeyError, IndexError, AttributeError):
        first_result = 'unknown format'
        messages = [f"First Prompt: {first_prompt}\nResponse: unknown format"]
    
    # Clean up the first result by removing any extraneous characters
    first_result_cleaned = first_result.strip("'\"")

    # Determine if a second prompt is needed based on the cleaned first result and document type
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
        return 'true' if final_result else 'false'  
    
    return 'true' if first_result_cleaned == 'true' else 'false' 

def upload_and_process_file(file, first_prompt, second_prompts=None):
    if file.filename == '':
        return jsonify(result=False, message='No selected file'), 400

    if file:
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(file_path)
        result = process_image_with_prompts(file_path, first_prompt, second_prompts)
        print(result)
        return jsonify(result=result, message='File processed successfully', file_path=file_path)
    else:
        return jsonify(result=False, message='File upload failed'), 500


@app.route('/upload/passport', methods=['POST'])
def upload_passport():
    first_prompt = "Is this a passport containing keywords 'Passport','date of issue','date of expiry'? Answer with 'True' or 'False'."
    return upload_and_process_file(request.files.get('file'), first_prompt)

@app.route('/upload/employment_pass', methods=['POST'])
def upload_employment_pass():
    first_prompt = "Is this an Singapore employment pass? Answer with 'work permit' or 'ltvp' or 'employment pass' or 's pass' or 'personalised employment pass', 'tech. pass', 'international organisation pass', 'overseas and network pass' or 'False'."
    second_prompts = {
        'employment pass': "Does this document contain keywords like 'Employment Pass', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        's pass': "Does this document contain keywords like 'S pass', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'work permit': "Does this document contain keywords like 'Work Permit', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'personalised employment pass': "Does this document contain keywords like 'personalised employment pass', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'overseas and network pass': "Does this document contain keywords like 'Overseas Networks & Expertise Pass', 'Employment of Foreign Manpower Act (Chapter 91A)', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'ltvp': "Does this document contain keywords like 'Long-Term Visit Pass', 'Immigration and Checkpoints Authority', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'tech. pass': "Does this document contain keywords like 'Tech Pass', 'Ministry of Manpower', 'Republic of Singapore'? Answer with 'True' or 'False'.",
        'international organisation pass': "Does this document contain keywords like 'International Organisation Pass', 'Ministry of Manpower', 'Republic of Singapore'? Answer with 'True' or 'False'."
    }
    return upload_and_process_file(request.files.get('file'), first_prompt, second_prompts)

@app.route('/upload/income_tax', methods=['POST'])
def upload_income_tax():
    first_prompt = "Is this an income tax document containing keywords like Income Tax – Notice of Assessment (Original), INCOME^, DEDUCTIONS, CHARGEABLE INCOME, YEAR OF ASSESSMENT? Answer with 'True' or 'False'."
    return upload_and_process_file(request.files.get('file'), first_prompt)

@app.route('/upload/proof_of_address', methods=['POST'])
def upload_proof_of_address():
    first_prompt = "Is this a document that contains a valid Singapore address with a block number and street name (e.g., ‘123 Jurong East St 32’), building name if applicable (e.g., ‘Jurong East Mall’), unit number (e.g., ‘#08-01’), and postal code (6-digit number, e.g., ‘600123’)? Answer with 'True' or 'False'."
    return upload_and_process_file(request.files.get('file'), first_prompt)

@app.route('/upload/payslip', methods=['POST'])
def upload_payslip():
    first_prompt = "Is this a payslip containing keywords like cpf, bank? Answer with 'True' or 'False'."
    return upload_and_process_file(request.files.get('file'), first_prompt)

if __name__ == 'main':
    port = int(os.environ.get("PORT", 8080))
    app.run(debug=True, host='0.0.0.0', port=port)
