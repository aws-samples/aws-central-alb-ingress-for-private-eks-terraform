#!/bin/bash

set -e
set -o pipefail


AWS_S3_COMMAND="aws s3api create-bucket --bucket"
S3_BUCKET_NAME="$1"; shift
REGION="$1"; shift
PROFILE="$1"; shift

#PROFILE="default"
#DEFVALUE=1
#AWS_CLI_PROFILE=${1:$PROFILE}

function main {
  local S3_BUCKET_NAME="$1"; shift
  local REGION="$1"; shift
  local PROFILE="$1" ; shift

  echo "Creating terraform state bucket for eks-service-account"
  $AWS_S3_COMMAND "$S3_BUCKET_NAME" --region "$REGION" --profile "$PROFILE" --create-bucket-configuration LocationConstraint="$REGION"
  }

main "$S3_BUCKET_NAME" "$REGION" "$PROFILE"

echo "Terraform state bucket for '$S3_BUCKET_NAME' is successfully created"