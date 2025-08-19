import requests
from requests.auth import HTTPBasicAuth

url = "https://httpbin.org/test"
headers = {
    "Content-Type": "application/yang-data+json",
    "Accept": "application/yang-data+json"
}
data = {
    "severity": "alerts"
}

response = requests.post(
    url,
    headers=headers,
    auth=HTTPBasicAuth('admin', 'admin'),
    json=data,
    verify=False
)

print("Status Code:", response.status_code)
print("Response Headers:", response.headers)
print("Response Body:", response.text)