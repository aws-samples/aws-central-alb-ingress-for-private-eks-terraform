resource "aws_eks_node_group" "managed-nodes" {
  provider = aws.eks-admin

  for_each = var.node-groups

  cluster_name    = aws_eks_cluster.control-plane.name
  node_group_name = each.value.name
  node_role_arn   = aws_iam_role.eks-data-plane.arn
  instance_types  = [each.value.instance-type]
  subnet_ids = concat(
    var.cluster-data-plane-subnet-ids
  )

  scaling_config {
    desired_size = each.value.desired-size
    max_size     = each.value.max-size
    min_size     = each.value.min-size
  }

  labels  = each.value.k8s-labels

  release_version = lookup(var.ami-versions, var.control-plane-version)

  tags = {
    Name       = each.key
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.CloudWatchAgentServerPolicy,
    aws_iam_role_policy_attachment.Amazon_EBS_CSI_Driver,
    aws_iam_service_linked_role.eks-nodegroup
  ]
}
