# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "private_cidr" {
  type = string
}

variable "cluster-name" {
  type = string
}

variable "account_name" {
  type = string
  default = "eks"
}