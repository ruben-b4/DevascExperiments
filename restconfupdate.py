import requests
from requests.auth import HTTPBasicAuth
import urllib3

# Disable SSL warnings
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Use httpbin to simulate the RESTCONF endpoint
url = "https://httpbin.org/patch"

headers = {
    "Content-Type": "application/yang-data+json",
    "Accept": "application/yang-data+json"
}

# Payload from the curl example
data = {
    "native": {
        "logging": {
            "monitor": {
                "severity": "informational"
            }
        }
    }
}

# Send PATCH request
response = requests.patch(
    url,
    json=data,
    headers=headers,
    auth=HTTPBasicAuth('admin', 'admin'),  # still included to mirror router example
    verify=False,
    timeout=5
)

# Print results
print("Status Code:", response.status_code)
print("Response JSON:", response.json())
