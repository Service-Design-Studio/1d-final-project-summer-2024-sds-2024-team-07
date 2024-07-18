from flask import Flask, request, jsonify, flash
import vertexai
from vertexai.preview.generative_models import GenerativeModel, Image
from google.oauth2 import service_account
import os

app = Flask(__name__)

PROJECT_ID = "dbsdoccheckteam7"
REGION = "asia-east1"

# Get the directory of the current script
script_dir = os.path.dirname(os.path.abspath(__file__))

# app.secret_key = 'supersecretkey'  # Replace with a real secret key in production

SERVICE_ACCOUNT_FILE = os.path.join(script_dir, 'dbsdoccheckteam7-7b5fc6a831cc.json')

# Authenticate using the service account key file
credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE)
vertexai.init(project=PROJECT_ID, location=REGION, credentials=credentials)



UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
def index():
    return 'Flask backend is running'

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify(result=False, message='No file part'), 400
    
    file = request.files['file']
    
    if file.filename == '':
        return jsonify(result=False, message='No selected file'), 400
    
    if file:
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(file_path)
        
        # Run your Python script here
        result = process_image(file_path)
        
        return jsonify(result=result, message='File processed successfully', file_path=file_path)
    else:
        return jsonify(result=False, message='File upload failed'), 500
    
def process_image(file_path):
    image = Image.load_from_file(file_path)
    generative_multimodal_model = GenerativeModel("gemini-1.5-pro-001")
    response = generative_multimodal_model.generate_content(["Is this image a income slip? Answer only with 'True' or 'False'.", image])
    return response.text

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8080))
    app.run(debug=True, host='0.0.0.0', port=port)