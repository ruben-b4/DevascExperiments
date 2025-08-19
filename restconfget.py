import requests
from requests.auth import HTTPBasicAuth

url = "https://httpbin.org/get"
username = "admin"
password = "admin"

headers = {
    "Accept": "application/yang-data+json"
}

# Send GET request
response = requests.get(url, headers=headers, auth=HTTPBasicAuth(username, password), verify=False)

# Print status code and response
print("Status Code:", response.status_code)
print("Response Body:", response.text)