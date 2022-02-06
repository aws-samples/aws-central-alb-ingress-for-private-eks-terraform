variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "private_cidr" {
  type = string
  default = "10.12.0.0/16"
}

variable "s3_state_bucket" {
  type = string
  default = "central-internet-acc"
  description = "Name of s3 state bucket created with the s3_state_bukcet.sh"
}

variable "access_logs_bucket" {
  type = string
  default = "internet-ingress-alb-access-logs"
}