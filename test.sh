#!/bin/bash
JSONFILE=~/.keycloak_test.json

IP=(`hostname -I`)

keycloak-curl.sh $IP:8080 test test test testapp C2P5VyTEEP4xd15a14as10ooj6f5Rvhd > $JSONFILE

TOKEN=(`awk -F '"' '{print $4}' $JSONFILE | tail -1`)
JWT=`pyjwt decode --no-verify "$TOEKN"`
EXP=(`echo $JWT | awk '{print $2}'`)

echo [TOKEN]===================================================================
echo $TOKEN
if [ "$JWT" != "" ]; then
echo [PARSING]=================================================================
echo $JWT
echo ==========================================================================
echo exp: `date --date=@${EXP:0:10}`
fi