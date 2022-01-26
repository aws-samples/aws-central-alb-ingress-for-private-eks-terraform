variable "vpc_id" {
  type = string
}

variable "name" {
  description = "Team this endpoint is pointing to"
}


variable "team_endpoint_private_ips" {}

variable "listener_arn" {
  type = string
}
/*variable "subdomain" {
  type = string
}

variable "dns_zone_id" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "alb_dns_zone_id" {
  type = string
}*/
