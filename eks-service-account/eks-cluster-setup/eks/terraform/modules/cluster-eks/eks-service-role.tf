################################
# EKS Service
################################

data "aws_iam_policy_document" "eks-assume-role" {

  provider = aws.iam-full-access

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "AmazonEKSServicePolicy" {

  provider = aws.iam-full-access

  arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

data "aws_iam_policy" "AmazonEKSClusterPolicy" {

  provider = aws.iam-full-access

  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks-service" {

  provider = aws.iam-full-access

  name               = "AmazonEKSServiceRole"
  assume_role_policy = data.aws_iam_policy_document.eks-assume-role.json

  tags = {
    Name       = "AmazonEKSServiceRole"
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {

  provider = aws.iam-full-access

  policy_arn = data.aws_iam_policy.AmazonEKSServicePolicy.arn
  role       = aws_iam_role.eks-service.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {

  provider = aws.iam-full-access

  policy_arn = data.aws_iam_policy.AmazonEKSClusterPolicy.arn
  role       = aws_iam_role.eks-service.name
}

resource "aws_iam_service_linked_role" "eks" {

  provider = aws.iam-full-access

  aws_service_name = "eks.amazonaws.com"
}
