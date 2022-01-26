output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_endpoint_subnet_cidrs" {
  value = module.vpc.private_endpoint_subnet_cidrs
}

output "public_ingress_subnet_cidrs" {
  value = module.vpc.public_ingress_subnet_cidrs
}

output "public_ingress_route_table" {
  value = module.vpc.public_ingress_route_table
}

output "public_ingress_subnet_ids" {
  value = module.vpc.public_ingress_subnet_ids
}

output "private_endpoint_subnet_ids" {
  value = module.vpc.private_endpoint_subnet_ids
}

output "caller" {
  value = data.aws_caller_identity.current.account_id
}

output "eni-ids" {
  value = module.endpoint.eni_ids
}

output "eni-ips" {
  value = module.endpoint.eni_ips
}