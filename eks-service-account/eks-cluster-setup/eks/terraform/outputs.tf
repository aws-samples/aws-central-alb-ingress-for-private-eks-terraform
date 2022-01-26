# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

################################
# Cluster
################################

output "eks-id" {
  value = module.eks.cluster-id
}

output "eks-name" {
  value = module.eks.cluster-name
}

output "eks-arn" {
  value = module.eks.cluster-arn
}

output "eks-kubeconfig-certificate-authority-data" {
  value = module.eks.kubeconfig-certificate-authority-data
}

output "eks-api-endpoint" {
  value = module.eks.api-endpoint
}

output "eks-platform-version" {
  value = module.eks.platform-version
}

output "eks-k8s-version" {
  value = module.eks.k8s-version
}

output "eks-security-group-id" {
  value = module.eks.eks-security-group-id
}

output "eks-identity-issuer-url" {
  value = module.eks.eks-cluster-identity-issuer-url
}

output "eks-node-groups" {
  value = module.eks.eks-node-groups
}

################################
# Roles
################################

output "eks-servirole-arn" {
  value = module.eks.eks-service-role-arn
}

output "eks-data-plane-role-arn" {
  value = module.eks.eks-data-plane-role-arn
}
