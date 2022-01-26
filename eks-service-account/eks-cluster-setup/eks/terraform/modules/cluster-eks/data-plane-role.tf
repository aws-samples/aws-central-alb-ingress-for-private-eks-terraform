################################
# EKS Data Plane
################################

data "aws_iam_policy_document" "eks-node-assume-role" {

  provider = aws.iam-full-access

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "eks-data-plane" {

  provider = aws.iam-full-access

  name               = "eks-data-plane"
  assume_role_policy = data.aws_iam_policy_document.eks-node-assume-role.json

  tags = {
    Name       = "eks-data-plane"
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {

  provider = aws.iam-full-access

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-data-plane.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {

  provider = aws.iam-full-access

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-data-plane.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {

  provider = aws.iam-full-access

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-data-plane.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {

  provider = aws.iam-full-access

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.eks-data-plane.name
}

resource "aws_iam_service_linked_role" "eks-nodegroup" {

  provider = aws.iam-full-access

  aws_service_name = "eks-nodegroup.amazonaws.com"
}

resource "aws_iam_policy" "Amazon_EBS_CSI_Driver" {

  provider = aws.iam-full-access

  policy = file("${path.module}/policies/ebs.json")
  name   = "Amazon_EBS_CSI_Driver"
}

resource "aws_iam_role_policy_attachment" "Amazon_EBS_CSI_Driver" {
  provider = aws.iam-full-access

  policy_arn = aws_iam_policy.Amazon_EBS_CSI_Driver.arn
  role       = aws_iam_role.eks-data-plane.name
}
