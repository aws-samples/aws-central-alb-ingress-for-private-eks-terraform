terraform {
  backend "s3" {
    bucket     = "central-internet-acc"
    region     = "eu-central-1"
    key        = "networking"
    profile    = "central-acc"
  }
}
