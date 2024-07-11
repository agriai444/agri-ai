import requests

# Hugging Face Inference API endpoint
endpoint = "https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.2"

# Example text for classification
text = "What is java"

# API request payload
payload = {
    "inputs": text
}

# Set up authentication headers with your API token
headers = {
    "Authorization": f"Bearer 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",
    "Content-Type": "application/json"
}

# Send POST request to the API endpoint
response = requests.post(endpoint, headers=headers, json=payload)

# Parse and print the prediction
if response.status_code == 200:
    result = response.json()
    print("Predicted class:", result[])
else:
    print("Request failed with status code:", response.status_code)
