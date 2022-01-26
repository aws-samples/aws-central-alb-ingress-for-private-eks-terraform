# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_security_group" "aws-ecr-endpoint" {
  provider = aws.network-role
  name        = "aws-endpoints"
  description = "Security Group for controlling access to AWS VPC endpoints"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name       = "ecr-endpoint"
  }
}

resource "aws_security_group_rule" "aws-endpoints-eks-ingress" {
  provider = aws.network-role
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.aws-ecr-endpoint.id
  cidr_blocks       = module.vpc.cluster-data-plane-cidrs
  to_port           = 0
  type              = "ingress"
  description       = "Ingress from EKS data plane to ECR"
}


resource "aws_vpc_endpoint" "ecr-api" {
  provider = aws.network-role
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-central-1.ecr.api"
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.cluster-data-plane-subnet-ids
  tags = {
    Name       = "ecr-api"
  }
  security_group_ids = [aws_security_group.aws-ecr-endpoint.id]
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  provider = aws.network-role
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-central-1.ecr.dkr"
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.cluster-data-plane-subnet-ids
  tags = {
    Name       = "ecr-dkr"
  }
  security_group_ids = [aws_security_group.aws-ecr-endpoint.id]
}

resource "aws_vpc_endpoint" "s3" {
  provider = aws.network-role
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-central-1.s3"
  vpc_endpoint_type   = "Gateway"
  tags = {
    Name       = "s3"
  }
  route_table_ids = [module.vpc.cluster-data-plane-route-table]
}

resource "aws_vpc_endpoint" "ec2" {
  provider = aws.network-role
  service_name = "com.amazonaws.eu-central-1.ec2"
  vpc_id = module.vpc.vpc_id
  private_dns_enabled = true
  subnet_ids          = module.vpc.cluster-data-plane-subnet-ids
  vpc_endpoint_type = "Interface"
  tags = {
    Name        = "ec2"
  }
  security_group_ids = [aws_security_group.aws-ecr-endpoint.id]
}

resource "aws_vpc_endpoint" "lb" {
  provider = aws.network-role
  service_name = "com.amazonaws.eu-central-1.elasticloadbalancing"
  vpc_id = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"
  subnet_ids            = module.vpc.cluster-data-plane-subnet-ids
  private_dns_enabled = true
  tags = {
    Name = "lb"
  }
  security_group_ids = [aws_security_group.aws-ecr-endpoint.id]
}

resource "aws_vpc_endpoint" "sts" {
  provider = aws.network-role
  service_name = "com.amazonaws.eu-central-1.sts"
  vpc_id = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"
  subnet_ids            = module.vpc.cluster-data-plane-subnet-ids
  private_dns_enabled = true
  tags = {
    Name = "sts"
  }
  security_group_ids = [aws_security_group.aws-ecr-endpoint.id]

}

resource "aws_vpc_endpoint" "as" {
  provider = aws.network-role
  service_name = "com.amazonaws.eu-central-1.autoscaling"
  vpc_id = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"
  subnet_ids            = module.vpc.cluster-data-plane-subnet-ids
  private_dns_enabled = true
  tags = {
    Name = "as"
  }
  security_group_ids = [aws_security_group.aws-ecr-endpoint.id]

}

