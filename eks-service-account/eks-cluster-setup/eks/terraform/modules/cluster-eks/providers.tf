provider "aws" {
  alias = "eks-admin"
  region = "eu-central-1"
}

provider "aws" {
  alias = "iam-full-access"
  region = "eu-central-1"
}