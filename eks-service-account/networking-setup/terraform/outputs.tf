# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "vpc-id" {
  value = module.vpc.vpc_id
}

output "cluster-data-plane-subnet-ids" {
  value = module.vpc.cluster-data-plane-subnet-ids
}

output "cluster-data-plane-cidrs" {
  value = module.vpc.cluster-data-plane-cidrs
}

output "ecr" {
  value = aws_ecr_repository.ecr.id
}