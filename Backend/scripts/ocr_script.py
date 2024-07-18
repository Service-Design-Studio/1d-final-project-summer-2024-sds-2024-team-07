import os
import vertexai
from vertexai.preview.generative_models import GenerativeModel, Image
from google.oauth2 import service_account

PROJECT_ID = "dbsdoccheckteam7"
REGION = "asia-east1"

# Get the directory of the current script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Construct the relative path to the service account file
SERVICE_ACCOUNT_FILE = os.path.join(script_dir, '../dbsdoccheckteam7-7b5fc6a831cc.json')

# Authenticate using the service account key file
credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE)
vertexai.init(project=PROJECT_ID, location=REGION, credentials=credentials)

# Construct the relative path to the image file
IMAGE_FILE = "./app/assets/images/income-slip.png"
image = Image.load_from_file(IMAGE_FILE)

generative_multimodal_model = GenerativeModel("gemini-1.5-pro-001")
response = generative_multimodal_model.generate_content(["What is shown in this image?", image])

print(response)
