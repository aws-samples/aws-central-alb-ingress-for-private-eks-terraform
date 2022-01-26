# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "vpc_id" {
  value = aws_vpc.main.id
}

output "cluster-data-plane-cidrs" {
  value = aws_subnet.cluster-data-plane[*].cidr_block
}

output "cluster-data-plane-route-table" {
  value = aws_route_table.cluster-data-plane.id
}

output "cluster-data-plane-subnet-ids" {
  value = aws_subnet.cluster-data-plane[*].id
}