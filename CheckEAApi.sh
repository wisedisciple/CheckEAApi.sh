#!/bin/bash

client_id=""
client_secret=""
url=""
##This output has multiple values, use plutil to extract the token
getAccessToken() {
	response=$(curl --silent --location --request POST "${url}/api/oauth/token" \
		--header "Content-Type: application/x-www-form-urlencoded" \
		--data-urlencode "client_id=${client_id}" \
		--data-urlencode "grant_type=client_credentials" \
		--data-urlencode "client_secret=${client_secret}")
	access_token=$(echo "$response" | plutil -extract access_token raw -) 
	
}
getAccessToken
#echo "$access_token"

#curl -X GET "$url/JSSResource/mobiledevices/id/10" -H 'Accept: application/xml' -H "Authorization: Bearer $access_token" | xmllint --format -

curl -X PUT "$url/JSSResource/mobiledevices/id/10" -H 'Content-Type: text/xml' -H "Authorization: Bearer $access_token" -d "<mobile_device><extension_attributes><extension_attribute><name>Ready?</name><value>Ready</value></extension_attribute></extension_attributes></mobile_device>"
