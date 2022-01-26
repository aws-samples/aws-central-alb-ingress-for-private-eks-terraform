resource "aws_subnet" "private-endpoint-subnets" {
  count             = 3
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.private_cidr, 7, count.index)
  vpc_id            = aws_vpc.main.id

  tags = {
    Name       = "private-endpoint-subnets-${data.aws_availability_zones.available.zone_ids[count.index]}"
  }
}

