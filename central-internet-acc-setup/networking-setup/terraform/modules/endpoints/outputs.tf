output "eni_ids" {
  value = toset(aws_vpc_endpoint.endpoint.network_interface_ids)
}

output "eni_ips" {
  value = data.aws_network_interface.eni_ips[*].private_ip
}
//output "eni_ips" {
//  value = values(data.aws_network_interface.eni_ips)[*].private_ip
//}
