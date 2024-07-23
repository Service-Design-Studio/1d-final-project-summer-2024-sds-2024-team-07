from flask import Flask, request, jsonify
import os
import vertexai
from vertexai.preview.generative_models import GenerativeModel,  Image
from google.oauth2 import service_account
from flask_cors import CORS
import logging
import fitz  # PyMuPDF
from PIL import Image as PIL_Image
import io
# from google.cloud import vision

app = Flask(__name__)
CORS(app)

PROJECT_ID = "dbsdoccheckteam7"
REGION = "asia-east1"

# Get the directory of the current script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Construct the relative path to the service account file
SERVICE_ACCOUNT_FILE = os.path.join(script_dir, 'dbsdoccheckteam7-7b5fc6a831cc.json')

# Authenticate using the service account key file
credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE)
vertexai.init(project=PROJECT_ID, location=REGION, credentials=credentials)

ALLOWED_EXTENSIONS = ('png', 'jpg', 'jpeg', 'pdf')
ALLOWED_MIMETYPES = ('image/png', 'image/jpeg', 'application/pdf')
MAX_FILE_SIZE = 5 * 1024 * 1024 #5MB

logging.basicConfig(level=logging.INFO)

def allowed_file(filename, file_mimetype):
    return '.' in filename and \
    filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS and \
    file_mimetype in ALLOWED_MIMETYPES

def convert_pdf_to_image(pdf_path, image_path):
    pdf_doc = fitz.open(pdf_path)
    page = pdf_doc.load_page(0) #get the first pg
    pix =  page.get_pixmap() # render pg to an image
    pix.save(image_path)

# Construct the relative path to the image file
# IMAGE_FILE = "./app/assets/images/income-slip.png"
# image = Image.load_from_file(IMAGE_FILE)

# generative_multimodal_model = GenerativeModel("gemini-1.5-pro-001")
# response = generative_multimodal_model.generate_content(["What is shown in this image? If an income slip with cpf contributions is shown, answer yes else no", image])

import time
import random

def analyze_image(file_path):
    # Initialize the generative multimodal model
    generative_multimodal_model = GenerativeModel("gemini-1.5-pro-001")
    
    # Function to handle exponential backoff
    def generate_content_with_backoff(prompt, image, retries=5):
        for i in range(retries):
            try:
                # Generate content
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
    
    if file_path.lower().endswith('.pdf'):
        image_path = file_path.replace('.pdf', '.png')
        convert_pdf_to_image(file_path, image_path)
        image = Image.load_from_file(image_path)
    else:  
        image = Image.load_from_file(image_path)

    # Create the initial prompt to classify the image
    prompt_classify = ("Is this image an income slip, a passport, a proof of address document, "
                       "an employment pass, or an income tax document? Answer with "
                       "'income slip', 'passport', 'proof of address', 'employment pass', or 'income tax'.")
    
    # Generate content for classification with backoff
    response_classify = generate_content_with_backoff(prompt_classify, image)
    
    # Print the full classification response for debugging
    print("Classification Response:", response_classify)
    
    # Extract the classification result from the response
    try:
        classification = response_classify.candidates[0].content.parts[0].text.strip().lower()
    except (KeyError, IndexError, AttributeError) as e:
        classification = 'unknown format'
    
    print("Classification Result:", classification)
    
    # Further classify proof of address or employment pass documents
    if classification == 'proof of address':
        prompt_proof_of_address = ("Is this document a Letter of offer/employment, Local utility/telecommunication bill, "
                                   "Local bank statement/credit card statement, In-Principle Approval (IPA) issued by Ministry of Manpower, "
                                   "In-Principle Approval (IPA) issued from ICA, or Work permit of foreign domestic worker issued by Ministry of Manpower? "
                                   "Answer with 'letter of offer/employment', 'utility bill', 'bank statement', 'ipa mom', 'ipa ica', or 'work permit'.")
        
        response_proof_of_address = generate_content_with_backoff(prompt_proof_of_address, image)
        
        # Print the full response for debugging
        print("Proof of Address Classification Response:", response_proof_of_address)
        
        # Extract the proof of address classification result
        try:
            secondary_classification = response_proof_of_address.candidates[0].content.parts[0].text.strip().lower()
            secondary_classification = secondary_classification.strip("'\"")  # Remove extra quotation marks
        except (KeyError, IndexError, AttributeError) as e:
            secondary_classification = 'unknown format'
        
        print("Proof of Address Classification Result:", secondary_classification)
        classification = secondary_classification  # Update classification for cross-checking
    
    elif classification == 'employment pass':
        prompt_employment_pass = ("Is this document an Employment Pass, S Pass, Personalised Employment Pass, Long-Term Visit Pass with LOC, "
                                  "Tech Pass, International Organisation Pass, or Overseas Networks & Expertise Pass? "
                                  "Answer with 'employment pass', 's pass', 'personalised employment pass', 'ltvp loc', 'tech pass', "
                                  "'international organisation pass', or 'one pass'.")
        
        response_employment_pass = generate_content_with_backoff(prompt_employment_pass, image)
        
        # Print the full response for debugging
        print("Employment Pass Classification Response:", response_employment_pass)
        
        # Extract the employment pass classification result
        try:
            secondary_classification = response_employment_pass.candidates[0].content.parts[0].text.strip().lower()
            secondary_classification = secondary_classification.strip("'\"")  # Remove extra quotation marks
        except (KeyError, IndexError, AttributeError) as e:
            secondary_classification = 'unknown format'
        
        print("Employment Pass Classification Result:", secondary_classification)
        classification = secondary_classification  # Update classification for cross-checking

    # Define preset descriptions for cross-checking
    preset_descriptions = {
        'income slip': 'headings like basic month, allowances, and cpf contributions',
        'passport': 'headings like name, nationality, and date of birth',
        'letter of offer/employment': 'headings like employer, job title, and salary details',
        'utility bill': 'headings like service provider, account number, and billing period',
        'bank statement': 'headings like bank name, account number, and transaction details',
        'ipa mom': 'headings like Ministry of Manpower, approval status, and work pass details',
        'ipa ica': 'headings like Immigration and Checkpoints Authority, approval status, and pass details',
        'work permit': 'headings like Ministry of Manpower, work permit number, and foreign domestic worker details',
        'employment pass': 'headings like Employment Pass, S Pass, and work pass details',
        's pass': 'headings like S Pass, Ministry of Manpower, and work pass details',
        'personalised employment pass': 'headings like Personalised Employment Pass, Ministry of Manpower, and work pass details',
        'ltvp loc': 'headings like Long-Term Visit Pass, LOC, and work pass details',
        'tech pass': 'headings like Tech Pass, Ministry of Manpower, and work pass details',
        'international organisation pass': 'headings like International Organisation Pass, Ministry of Manpower, and work pass details',
        'one pass': 'headings like Overseas Networks & Expertise Pass, Ministry of Manpower, and work pass details',
        'income tax': 'headings like income tax, IRAS, and tax assessment'
    }
    
    # Create the cross-check prompt
    if classification in preset_descriptions:
        description_to_check = preset_descriptions[classification]
        print(f"Description to be checked: {description_to_check}")
        prompt_cross_check = f"Does this document have {description_to_check}? Answer with 'True' or 'False'."
    else:
        print("Unknown image type. Cannot cross-check.")
        return "Unknown image type. Cannot cross-check."

    # Generate content for cross-checking with backoff
    response_cross_check = generate_content_with_backoff(prompt_cross_check, image)
    
    # Print the full cross-check response for debugging
    print("Cross-check Response:", response_cross_check)
    
    # Extract the cross-check result from the response
    try:
        cross_check_result = response_cross_check.candidates[0].content.parts[0].text.strip().lower()
    except (KeyError, IndexError, AttributeError) as e:
        cross_check_result = 'unknown format'
    
    print("Cross-check Result:", cross_check_result)
    
    # Ensure the result is either 'true' or 'false'
    if cross_check_result not in ['true', 'false']:
        cross_check_result = 'unknown format'
    
    # Return the final result
    return cross_check_result

@app.route('/')
def index():
    return "Welcome to the OCR API. Use /analyze endpoint to analyze images."

@app.route('/analyze', methods=['POST'])

@app.route('/analyze', methods=['POST'])
def analyze():
    logging.info("Received request at /analyze")
    if 'file' not in request.files:
        logging.error("No file part in the request")
        return jsonify({"error": "No file part"}), 400

    file = request.files['file']
    logging.info("Received file: %s", file.filename)

    if file.filename == '':
        logging.error("No file selected")
        return jsonify({"error": "No file selected"}), 400

    if file and allowed_file(file.filename, file.mimetype):
        if file.content_length > MAX_FILE_SIZE:
            logging.error("File size exceeds limit")
            return jsonify({"error": "File size exceeds limit"}), 400

        # Save the file to the tmp directory
        tmp_dir = os.path.join(script_dir, 'tmp')
        os.makedirs(tmp_dir, exist_ok=True)
        file_path = os.path.join(tmp_dir, file.filename)
        file.save(file_path)

        try:
            result = analyze_image(file_path)
            return jsonify({"result": result})
        finally:
            # Clean up the temporary file
            os.remove(file_path)
            # If a PDF was converted to an image, clean up the image file as well
            if file_path.lower().endswith('.pdf'):
                os.remove(file_path.replace('.pdf', '.png'))
    else:
        logging.error("Invalid file type")
        return jsonify({"error": "Invalid file type"}), 400

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)