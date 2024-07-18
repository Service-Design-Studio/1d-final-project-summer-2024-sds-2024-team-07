import os
import vertexai
from vertexai.preview.generative_models import GenerativeModel, Image
from google.oauth2 import service_account

PROJECT_ID = "dbsdoccheckteam7"
REGION = "asia-east1"

# Get the directory of the current script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Construct the relative path to the service account file
SERVICE_ACCOUNT_FILE = os.path.join(script_dir,  '..', 'dbsdoccheckteam7-7b5fc6a831cc.json')


# Authenticate using the service account key file
credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE)
vertexai.init(project=PROJECT_ID, location=REGION, credentials=credentials)

# Construct the relative path to the image file
IMAGE_FILE = os.path.join(script_dir,'..','..','Frontend', 'app', 'assets', 'images', 'income-slip.png')
image = Image.load_from_file(IMAGE_FILE)

# Define the prompt and image for the model

# Prompt the user for input
input_text = input("Please enter the information you want to extract: ")
# Define the prompt and image for the model
prompt = f"Only check the document or image that was given and nothing else. If {input_text} or any relevant details relating to {input_text} does not exist, return False. If it does exist and is relevant, return the what ${input_text} is and return True."

generative_multimodal_model = GenerativeModel("gemini-1.5-pro-001")
response = generative_multimodal_model.generate_content([prompt, image])

print(response.text)
