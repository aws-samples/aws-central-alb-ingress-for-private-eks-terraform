# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "eks" {
  source = "./modules/cluster-eks"
  providers = {
    aws.eks-admin       = aws.eks-admin
  }

  cluster-name          = local.service_config.cluster-name
  control-plane-version = local.service_config.control-plane.version

  # Networking
  control-plane-allowed-cidrs           = local.service_config.control-plane-allowed-cidrs
  cluster-data-plane-subnet-ids         = data.terraform_remote_state.networking.outputs.cluster-data-plane-subnet-ids
  #cluster-additional-security-group-ids = [data.terraform_remote_state.networking.outputs.aws-endpoints-security-group-id]


  # Data Plane
  node-groups = local.service_config.nodegroups
  ami-versions = local.service_config.versions
}