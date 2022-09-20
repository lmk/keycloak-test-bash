#!/bin/bash
#
# ref: https://github.com/akoserwal/keycloak-integrations/blob/master/curl-post-request/keycloak-curl.sh
#

IP=(`hostname -I`)

if [ $# -ne 5 ]; then
  echo 1>&2 "Usage: . $0 hostname realm username password clientid clientsecret"
  echo 1>&2 "  options:"
  echo 1>&2 "    hostname: $IP:8080"
  echo 1>&2 "    realm: test"
  echo 1>&2 "    username: test"
  echo 1>&2 "    password: test"
  echo 1>&2 "    clientid: testapp"
  echo 1>&2 "    clientsecret: C2P5VyTEEP4xd15a14as10ooj6f5Rvhd"
  echo 1>&2 "    For verify ssl: use 'y' (otherwise it will send curl post with --insecure)"
  
  exit
fi

HOSTNAME=$1
REALM_NAME=$2
USERNAME=$3
PASSWORD=$4
CLIENT_ID=$5
CLIENT_SECRET=$6
SECURE=$7

KEYCLOAK_URL=https://$HOSTNAME/auth/realms/$REALM_NAME/protocol/openid-connect/token

echo "Using Keycloak: $KEYCLOAK_URL"
echo "realm: $REALM_NAME"
echo "client-id: $CLIENT_ID"
echo "username: $USERNAME"
echo "secure: $CLIENT_SECRET"

if [[ $SECURE = 'y' ]]; then
	INSECURE=
else 
	INSECURE=--insecure
fi

export TOKEN=$(curl -X POST "$KEYCLOAK_URL" "$INSECURE" \
 -H "Content-Type: application/x-www-form-urlencoded" \
 -d "username=$USERNAME" \
 -d "password=$PASSWORD" \
 -d 'grant_type=password' \
 -d "client_secret=$CLIENT_SECRET" \
 -d "client_id=$CLIENT_ID")

echo $TOKEN

if [[ $(echo $TOKEN) != 'null' ]]; then
	export KEYCLOAK_TOKEN=$TOKEN
fi
