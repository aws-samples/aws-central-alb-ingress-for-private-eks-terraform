# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

provider "aws" {
  region = "eu-central-1"
  profile = "central-acc"
}

module "iam_roles" {
  source = "./modules/iam_roles"
  region = var.region
}
