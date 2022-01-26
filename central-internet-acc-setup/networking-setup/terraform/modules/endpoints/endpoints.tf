resource "aws_security_group" "allow_public_ingress" {
  provider = aws.network-role
  description = "Security Group for controlling access to team endpoints"
  vpc_id      = var.vpc_id
}


resource "aws_security_group_rule" "public_ingress" {
  provider = aws.network-role
  from_port         = 80
  protocol          = "TCP"
  security_group_id = aws_security_group.allow_public_ingress.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = var.public-ingress-subnet-cidrs
}

resource "aws_vpc_endpoint" "endpoint" {
  provider = aws.network-role
  vpc_id             = var.vpc_id
  vpc_endpoint_type  = "Interface"
  service_name       = var.endpoint_service_name
  security_group_ids = [aws_security_group.allow_public_ingress.id]
  subnet_ids         = var.private-endpoint-subnet-ids
}



data "aws_network_interface" "eni_ips" {
  provider = aws.network-role
  count    = 3
  #for_each = aws_vpc_endpoint.endpoint.network_interface_ids
  id       = sort(aws_vpc_endpoint.endpoint.network_interface_ids)[count.index]
  depends_on = [aws_vpc_endpoint.endpoint]
}
