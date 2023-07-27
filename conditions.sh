#!/bin/bash

role_name=$1
account_id=0

[[ ${role_name} == "bricks" ]] && account_id=990993849942
[[ ${role_name} == "shaghafi-stage" ]] && account_id=679090196942
[[ ${role_name} == "zlato" ]] && account_id=093610908574
[[ ${role_name} == "squadio" ]] && account_id=556968346218
[[ ${role_name} == "aanaab" ]] && account_id=630567903587
echo "$account_id"







