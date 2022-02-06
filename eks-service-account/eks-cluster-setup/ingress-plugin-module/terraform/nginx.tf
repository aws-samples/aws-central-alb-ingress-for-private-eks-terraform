# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "null_resource" "nginx" {
  provisioner "local-exec" {
    command = "aws eks --region eu-central-1 update-kubeconfig --name private-service-cluster && kubectl apply -f ${path.module}/nginx.yaml"
  }
}

data "kubernetes_service" "ingress-nginx-controller" {
  provider = kubernetes.kubernetes
  metadata {
    name = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }
  depends_on = [null_resource.nginx]
}

locals {
  lb_name = split("-", split(".", data.kubernetes_service.ingress-nginx-controller.status.0.load_balancer.0.ingress.0.hostname).0).0
}

data "aws_lb" "nlb" {
  provider = aws.network-role
  name     = local.lb_name
}

resource "aws_vpc_endpoint_service" "nginx-ingress-public" {

  provider                   = aws.network-role
  acceptance_required        = false
  network_load_balancer_arns = [data.aws_lb.nlb.arn]
  allowed_principals = ["arn:aws:iam::<aws-account-id>:role/network-role"]

  tags = {
    Name       = "nginx-ingress-public"
  }
  depends_on = [data.aws_lb.nlb]
}

resource "aws_ssm_parameter" "vpces-service-name" {
  provider = aws.central-acc
  name = "vpces-service-name-${var.connection_name}"
  type = "String"
  value = aws_vpc_endpoint_service.nginx-ingress-public.service_name
  depends_on = [aws_vpc_endpoint_service.nginx-ingress-public]
  overwrite = true
}