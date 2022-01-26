resource "aws_eks_cluster" "control-plane" {

  provider = aws.eks-admin

  name     = var.cluster-name
  role_arn = aws_iam_role.eks-service.arn

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = tolist(values(var.control-plane-allowed-cidrs))
    subnet_ids = var.cluster-data-plane-subnet-ids
    #security_group_ids = var.cluster-additional-security-group-ids
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  tags = {
    Name             = var.cluster-name
  }

  version = var.control-plane-version

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy
  ]

  timeouts {
    create = "30m"
    update = "60m"
    delete = "30m"
  }
}
