# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

provider "aws" {
  region = "eu-central-1"
  assume_role {
    role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/network-role-eks"
  }
  alias = "network-role"
}

provider "aws" {
  region = "eu-central-1"
  assume_role {
    role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecr-full-access-eks"
  }
  alias = "ecr-full-access"
}


