#!/bin/bash


account_id=$1
iam_role=$2
role_session_name=$3
region=$4
#declare -A credits

aws sts assume-role --duration-seconds 7200 \
--role-arn "arn:aws:iam::$account_id:role/$iam_role" \
--role-session-name $role_session_name > credits.json

readarray -t credits < <(sed -n '/{/,/}/{s/[^:]*:[^"]*"\([^"]*\).*/\1/p;}' credits.json)

AWS_ACCESS_KEY_ID=${credits[0]}
AWS_SECRET_ACCESS_KEY=${credits[1]}
AWS_SESSION_TOKEN=${credits[2]}

rm -r credits.json 

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID --profile $role_session_name 
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY --profile $role_session_name
aws configure set aws_session_token $AWS_SESSION_TOKEN --profile $role_session_name 

aws configure set region $region --profile $role_session_name 



AWS_DEFAULT_PROFILE=${role_session_name}
export $AWS_DEFAULT_PROFILE

echo $AWS_DEFAULT_PROFILE
aws sts get-caller-identity


export AWS_DEFAULT_PROFILE=${role_session_name}

#for key in "${!credits[@]}"
#do
#    echo "$key = ${credits[$key]}"
#done






