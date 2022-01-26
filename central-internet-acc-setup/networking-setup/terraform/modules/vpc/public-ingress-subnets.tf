resource "aws_subnet" "public-ingress" {
  count                   = 3
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(var.private_cidr, 7, count.index + 64)
  map_public_ip_on_launch = true

  vpc_id = aws_vpc.main.id

  tags = {
    Name       = format("public-ingress-%s", data.aws_availability_zones.available.zone_ids[count.index])
  }

}

resource "aws_route_table" "public-ingress" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name       = "public-ingress-rt"
  }
}

resource "aws_route" "public-ingress" {

  route_table_id         = aws_route_table.public-ingress.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet-gateway.id
}

resource "aws_route_table_association" "public-ingress" {
  count = 3

  subnet_id      = aws_subnet.public-ingress.*.id[count.index]
  route_table_id = aws_route_table.public-ingress.id
}
