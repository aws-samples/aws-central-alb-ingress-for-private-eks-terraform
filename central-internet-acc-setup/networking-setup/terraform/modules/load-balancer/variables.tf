variable "vpc_id" {
  type = string
}


variable "public_ingress_subnet_ids" {
  type = set(string)
}

variable "access_logs_bucket" {}