resource "aws_vpc" "main" {
  cidr_block = var.private_cidr

  # See need for enabling these flags in https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "central"
  }
}