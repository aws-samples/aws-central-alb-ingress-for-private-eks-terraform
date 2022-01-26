output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_endpoint_subnet_cidrs" {
  value = aws_subnet.private-endpoint-subnets[*].cidr_block
}

output "public_ingress_subnet_cidrs" {
  value = aws_subnet.public-ingress[*].cidr_block
}

output "public_ingress_route_table" {
  value = aws_route_table.public-ingress.id
}

output "public_ingress_subnet_ids" {
  value = aws_subnet.public-ingress[*].id
}

output "private_endpoint_subnet_ids" {
  value = aws_subnet.private-endpoint-subnets[*].id
}

