# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

data "aws_iam_policy_document" "eks-admin" {
  statement {
    sid       = "eks"
    actions   = ["eks:*"]
    resources = ["*"]
  }


  statement {
    sid = "iam"
    actions = [
      "iam:GetRole",
      "iam:PassRole",
      "iam:ListAttachedRolePolicies",
      "iam:GenerateCredentialReport",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:Get*",
      "iam:List*",
      "iam:SimulateCustomPolicy",
      "iam:SimulatePrincipalPolicy"
    ]
    resources = ["*"]
  }

  statement {
    sid       = "ec2"
    actions   = ["ec2:DescribeSubnets"]
    resources = ["*"]
  }

  statement {
    sid = "kms"
    actions = [
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:Decrypt"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks-policy" {
  name        = "eks-policy"
  description = "EKS Administrator"
  policy      = data.aws_iam_policy_document.eks-admin.json
}

resource "aws_iam_role" "eks-role" {
  name               = "eks-role"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_role_policy_attachment" "eks-admin" {

  policy_arn = aws_iam_policy.eks-policy.arn
  role       = aws_iam_role.eks-role.name
}