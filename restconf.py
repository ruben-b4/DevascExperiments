import requests
import urllib3

# Disable SSL warnings
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Instead of your router, use httpbin (public testing service)
base_url = "https://httpbin.org"

# Common headers (same as RESTCONF requires)
headers = {
    "Accept": "application/yang-data+json",
    "Content-Type": "application/yang-data+json"
}

# ---------- 1. OPTIONS Request ----------
print("\n=== OPTIONS Request ===")
url = f"{base_url}/anything/severity"
response = requests.options(url, headers=headers, verify=False)
print("Status:", response.status_code)
print("Headers:", response.headers)

# ---------- 2. POST Request ----------
print("\n=== POST Request ===")
url = f"{base_url}/anything/logging/monitor"
payload = {
    "severity": "alerts"
}
response = requests.post(url, headers=headers, json=payload, verify=False)
print("Status:", response.status_code)
print("Response JSON:", response.json())

# ---------- 3. PUT Request ----------
print("\n=== PUT Request ===")
url = f"{base_url}/anything/logging/monitor/severity"
payload = {
    "severity": "warnings"
}
response = requests.put(url, headers=headers, json=payload, verify=False)
print("Status:", response.status_code)
print("Response JSON:", response.json())