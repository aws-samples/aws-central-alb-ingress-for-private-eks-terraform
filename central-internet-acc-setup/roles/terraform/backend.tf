# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

terraform {
  backend "s3" {
    bucket     = "central-internet-acc"
    region     = "eu-central-1"
    key        = "roles"
    profile    = "central-acc"
  }
}