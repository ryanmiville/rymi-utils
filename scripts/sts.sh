#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title STS Credentials
# @raycast.mode silent

mfa() {
 local resp
 resp=$(op item get ebrv6sjr6okpwidowsh5u6bz3i --otp)
 echo "$resp"
}

token=$(mfa)

stsResponse=$(aws --profile prod sts get-session-token --serial-number "arn:aws:iam::911070201873:mfa/phone" --token-code "$token" --duration-seconds 43200 --output json)

accessKey=$(echo $stsResponse | jq '.Credentials.AccessKeyId' | tr -d '"')

secretKey=$(echo $stsResponse | jq '.Credentials.SecretAccessKey' | tr -d '"')

sessionToken=$(echo $stsResponse | jq '.Credentials.SessionToken' | tr -d '"')

aws configure set aws_access_key_id "$accessKey" --profile sts
aws configure set aws_secret_access_key "$secretKey" --profile sts
aws configure set aws_session_token "$sessionToken" --profile sts
aws configure set region us-east-1 --profile sts
