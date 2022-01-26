# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_vpc" "main" {
  cidr_block = var.private_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name                                        = "main-${var.account_name}"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}