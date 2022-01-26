# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "s3_state_bucket" {
  type = string
  default = "eks-service-account"
  description = "Name of s3 state bucket created with the s3_state_bukcet.sh"
}