#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SSO
# @raycast.argument1 { "type": "dropdown", "placeholder": "AWS Environment", "data": [{"title": "dev", "value": "dev"},{"title": "prod", "value": "prod"},{"title": "eu", "value": "eu"}] , "optional": false }
# @raycast.mode silent

case "$1" in
    "prod")
        export AWS_PROFILE="prod"
        export AWS_DEFAULT_REGION="us-east-1"
        ;;
    "dev")
        export AWS_PROFILE="dev"
        export AWS_DEFAULT_REGION="us-east-1"
        ;;
    "eu")
        export AWS_PROFILE="eu"
        export AWS_DEFAULT_REGION="eu-central-1"
        ;;
    *)
        echo "No matching profile and region for argument $1"
        return 1
        ;;
esac
echo $AWS_PROFILE
echo $AWS_DEFAULT_REGION
aws sso login --profile "$1"
