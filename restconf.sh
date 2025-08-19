#!/bin/bash

# Variabelen
IP_HOST="192.168.56.107"
RESTCONF_USERNAME="cisco"
RESTCONF_PASSWORD="cisco123!"
DATA_FORMAT="application/yang-data+json"
LOOPBACK_INTERFACE="Loopback199"
LOOPBACK_IP="10.1.99.1"

API_URL_PUT="https://${IP_HOST}/restconf/data/ietf-interfaces:interfaces/interface=${LOOPBACK_INTERFACE}"
API_URL_GET="https://${IP_HOST}/restconf/data/ietf-interfaces:interfaces"

OUTPUT_FILE="check_restconf_api.txt"

# JSON payload
read -r -d '' YANG_CONFIG << EOF
{
  "ietf-interfaces:interface": {
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
}
EOF


{
    echo "$(date)"
    echo "START REST API CALL"
    echo "============"
    echo "FIRST API CALL"
    echo "============"

    # PUT
    RESP_PUT=$(curl -s -o /tmp/resp_put.txt -w "%{http_code}" -u "$RESTCONF_USERNAME:$RESTCONF_PASSWORD" \
        -H "Accept: ${DATA_FORMAT}" \
        -H "Content-Type: ${DATA_FORMAT}" \
        -X PUT "${API_URL_PUT}" \
        -d "${YANG_CONFIG}" \
        -k)

    echo "Status Code: ${RESP_PUT}"
    echo "============"
    echo "SECOND API CALL"
    echo "============"

    # GET 
    RESP_GET=$(curl -s -o /tmp/resp_get.txt -w "%{http_code}" -u "$RESTCONF_USERNAME:$RESTCONF_PASSWORD" \
        -H "Accept: ${DATA_FORMAT}" \
        -H "Content-Type: ${DATA_FORMAT}" \
        -X GET "${API_URL_GET}" \
        -k)

    echo "Status Code: ${RESP_GET}"
    echo "Interfaces:"
    cat /tmp/resp_get.txt
    echo "END REST API CALL"
} > "$OUTPUT_FILE"