# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

terraform {
  backend "s3" {
    bucket     = "eks-service-account"
    region     = "eu-central-1"
    key        = "roles"
  }
}