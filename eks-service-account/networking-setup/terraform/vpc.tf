# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "vpc" {
  providers = {
    aws.network-role = aws.network-role
  }
  source         = "./modules/vpc"
  private_cidr   = var.vpc_cidr
  cluster-name = "private-service-cluster"
  region = "eu-central-1"
}