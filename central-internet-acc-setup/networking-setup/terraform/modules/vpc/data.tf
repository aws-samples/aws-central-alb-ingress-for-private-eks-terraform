# Allows the configuration to be generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}