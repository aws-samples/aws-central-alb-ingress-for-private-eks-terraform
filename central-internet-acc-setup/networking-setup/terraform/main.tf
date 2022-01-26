provider "aws" {
  region = "eu-central-1"
  profile = "central-acc"
}

provider "aws" {
  region = "eu-central-1"
  assume_role {
    role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/network-role-central"
  }
  alias = "network-role"
  profile = "central-acc"
}

data "aws_caller_identity" "current" {}

module "vpc" {
  providers = {
    aws.network-role = aws.network-role
  }
  source         = "./modules/vpc"
  private_cidr   = var.private_cidr
}

module "alb" {
  providers = {
    aws.network-role = aws.network-role
  }
  source = "./modules/load-balancer"
  vpc_id = module.vpc.vpc_id
  public_ingress_subnet_ids = module.vpc.public_ingress_subnet_ids
}

data "aws_ssm_parameter" "endpointservice" {
  name = "vpces-service-name-connectionv1"
}

module "endpoint" {
  providers = {
    aws.network-role = aws.network-role
  }
  source = "./modules/endpoints"
  vpc_id = module.vpc.vpc_id
  public-ingress-subnet-cidrs = module.vpc.public_ingress_subnet_cidrs
  private-endpoint-subnet-ids = module.vpc.private_endpoint_subnet_ids
  endpoint_service_name = data.aws_ssm_parameter.endpointservice.value
}


/*data "aws_network_interface" "eni_ips" {
  provider = aws.network-role
  count    = length(module.endpoint.eni_ids)
  #for_each = aws_vpc_endpoint.endpoint.network_interface_ids
  id       = sort(module.endpoint.eni_ids)[count.index]
}*/

module "target-group" {
    providers = {
      aws.network-role = aws.network-role
    }
    source = "./modules/target-group"
    name   = "internet-ingress"
    vpc_id = module.vpc.vpc_id
    listener_arn = module.alb.alb_https_listener_arn
    team_endpoint_private_ips = module.endpoint.eni_ips
 }
