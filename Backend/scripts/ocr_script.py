import google.generativeai as genai
from google.generativeai.types import ContentType
from PIL import Image
from IPython.display import Markdown
import time
import cv2

GOOGLE_API_KEY = "AIzaSyAvkyTyL2uLZVONtp8duRy46b7I2plzCRw"
genai.configure(api_key=GOOGLE_API_KEY)

# for m in genai.list_models():
#     if 'generateContent' in m.supported_generation_methods:
#     	print(m.name)

model = genai.GenerativeModel('gemini-1.5-pro-latest')

text_prompt = "What are the total gross wages?"
income_slip_image = Image.open('../../Frontend/app/assets/images/income-slip.png')

prompt = [text_prompt, income_slip_image]
response = model.generate_content(prompt)

# Print the entire response for debugging purposes
print(response)

# Check if the response contains any candidates
if response and 'candidates' in response and response.candidates:
    for candidate in response.candidates:
        if candidate.text:
            print(candidate.text)
        else:
            print("Content generation was blocked due to safety reasons.")
            print("Safety Ratings:")
            for rating in candidate.safety_ratings:
                print(f"Category: {rating.category}, Probability: {rating.probability}")
else:
    print("No valid response received.")
