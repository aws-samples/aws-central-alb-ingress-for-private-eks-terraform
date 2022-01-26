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
  region = "eu-central-1"
  assume_role {
    role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/network-role-eks"
  }
  alias = "network-role"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  alias = "kubernetes"
}
