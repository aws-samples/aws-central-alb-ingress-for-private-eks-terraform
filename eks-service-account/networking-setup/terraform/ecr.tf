# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_ecr_repository" "ecr" {
  provider = aws.ecr-full-access
  name = "eks-service-account-ecr"
}