# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

### IAM role permissions for setting networking components like (VPC, Subnets, VPCES) ###

locals {
  role_names_arns = {
    network-role-eks = "arn:aws:iam::aws:policy/job-function/NetworkAdministrator"
    iam-full-access-eks = "arn:aws:iam::aws:policy/IAMFullAccess"
    ecr-full-access-eks = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.arn]
    }
  }
}

### IAM role

resource "aws_iam_role" "aws_managed_role" {
  for_each = local.role_names_arns
  name = each.key
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
  tags = {
    Name    = each.key
  }
}

### IAM role policy attachment

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each = local.role_names_arns
  policy_arn = each.value
  role = aws_iam_role.aws_managed_role[each.key].name
}

