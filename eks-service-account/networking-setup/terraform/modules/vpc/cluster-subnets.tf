# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_subnet" "cluster-data-plane" {
  count             = 3
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.private_cidr, 5, count.index)
  vpc_id            = aws_vpc.main.id

  tags = {
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

resource "aws_route_table" "cluster-data-plane" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name       = "cluster-data-plane-rt"
  }
}

resource "aws_route_table_association" "cluster-data-plane" {
  count = 3

  subnet_id      = aws_subnet.cluster-data-plane.*.id[count.index]
  route_table_id = aws_route_table.cluster-data-plane.id
}

