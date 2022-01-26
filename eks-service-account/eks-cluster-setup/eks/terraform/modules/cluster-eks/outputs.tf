################################
# Cluster
################################

output "cluster-id" {
  value = aws_eks_cluster.control-plane.id
}

output "cluster-name" {
  value = aws_eks_cluster.control-plane.name
}

output "cluster-arn" {
  value = aws_eks_cluster.control-plane.arn
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.control-plane.certificate_authority.0.data
}

output "api-endpoint" {
  value = aws_eks_cluster.control-plane.endpoint
}

output "platform-version" {
  value = aws_eks_cluster.control-plane.platform_version
}

output "k8s-version" {
  value = aws_eks_cluster.control-plane.version
}

output "eks-security-group-id" {
  value = aws_eks_cluster.control-plane.vpc_config[0].cluster_security_group_id
}

output "eks-cluster-identity-issuer-url" {
  value = aws_eks_cluster.control-plane.identity.0.oidc.0.issuer
}

output "eks-node-groups" {
  value = aws_eks_node_group.managed-nodes
}

################################
# IAM Roles - Service Accounts
################################

/*output "compute-cluster-identity-provider-arn" {
  value = aws_iam_openid_connect_provider.compute-cluster.arn
}*/

################################
# Roles
################################

output "eks-service-role-arn" {
  value = aws_iam_role.eks-service.arn
}

output "eks-data-plane-role-arn" {
  value = aws_iam_role.eks-data-plane.arn
}