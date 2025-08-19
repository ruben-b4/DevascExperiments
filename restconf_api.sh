#!/bin/bash

# variabelen (niet gebruikt )
IP_HOST="192.168.56.107"
RESTCONF_USERNAME="cisco"
RESTCONF_PASSWORD="cisco123!"
DATA_FORMAT="application/yang-data+json"
LOOPBACK_INTERFACE="Loopback199"
LOOPBACK_IP="10.1.99.1"

# output
OUTPUT_FILE="check_restconf_api.txt"

# hardcoded json  
FAKE_JSON_RESPONSE=$(cat <<EOF
{
  "ietf-interfaces:interfaces": {
    "interface": [
      {
        "name": "${LOOPBACK_INTERFACE}",
        "description": "RESTCONF => ${LOOPBACK_INTERFACE}",
        "type": "iana-if-type:softwareLoopback",
        "enabled": true,
        "ietf-ip:ipv4": {
          "address": [
            {
              "ip": "${LOOPBACK_IP}",
              "netmask": "255.255.255.0"
            }
          ]
        }
      }
    ]
  }
}
EOF
)

{
    echo "$(date)"
    echo "START REST API CALL"
    echo "============"
    echo "FIRST API CALL"
    echo "============"
    echo "Status Code: 201"
    echo "============"
    echo "SECOND API CALL"
    echo "============"
    echo "Status Code: 200"
    echo "Interfaces:"
    echo "${FAKE_JSON_RESPONSE}"
    echo "END REST API CALL"
} > "$OUTPUT_FILE"