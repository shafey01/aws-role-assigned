#!/bin/bash

role_name=$1


account_id=$(./conditions.sh $role_name)
[[ ${account_id} == "0" ]] && echo "Please enter valid role name" && exit 1


aws sts assume-role --duration-seconds 3600 \
--role-arn "arn:aws:iam::$account_id:role/ibtikar_access" \
--role-session-name $role_name > credits.json

readarray -t credits < <(sed -n '/{/,/}/{s/[^:]*:[^"]*"\([^"]*\).*/\1/p;}' credits.json)

AWS_ACCESS_KEY_ID=${credits[0]}
AWS_SECRET_ACCESS_KEY=${credits[1]}
AWS_SESSION_TOKEN=${credits[2]}

rm -r credits.json 

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID --profile $role_name 
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY --profile $role_name
aws configure set aws_session_token $AWS_SESSION_TOKEN --profile $role_name 

aws configure set region eu-central-1 --profile $role_name 


export AWS_DEFAULT_PROFILE=$role_name
export AWS_PROFILE=$role_name

aws sts get-caller-identity







