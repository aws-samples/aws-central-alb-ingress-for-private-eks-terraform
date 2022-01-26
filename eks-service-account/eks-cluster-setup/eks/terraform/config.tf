# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

locals {
  service_config = yamldecode(file("./eks-config/service.yaml"))

}