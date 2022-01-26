# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

data "aws_caller_identity" "current" {}

################################
# Providers
################################
provider "aws" {
  region  = "eu-central-1"
  profile = "default"
}

provider "aws" {
  region  = "eu-central-1"
  profile = "central-acc"
  alias = "central-acc"
}

provider "aws" {
  region  = "eu-central-1"
  assume_role {
    role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/eks-role"
  }
  alias = "eks-admin"
}

provider "aws" {
  region  = "eu-central-1"
  assume_role {
    role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/iam-full-access-eks"
  }
  alias = "iam-full-access"
}

provider "aws" {
  region = "eu-central-1"
  assume_role {
    role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/network-role-eks"
  }
  alias = "network-role"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

################################
# Remote State
################################

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket     = var.s3_state_bucket
    region     = "eu-central-1"
    key        = "networking-setup"
  }
}

