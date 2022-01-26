################################
# Control Plane
################################

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "cluster-name" {
  type        = string
  description = ""
}

variable "control-plane-allowed-cidrs" {
  type        = map(any)
  description = ""

}

variable "cluster-data-plane-subnet-ids" {
  type        = list(string)
  description = ""
}

/*variable "cluster-lb-inbound-subnet-ids" {
  type        = list(string)
  description = ""
}*/

/*variable "cluster-additional-security-group-ids" {
  type        = list(string)
  description = ""
}*/

variable "control-plane-version" {
  type        = string
  description = ""
}

################################
# Data Plane
################################

# TO-DO: Accept map of node groups

variable "node-groups" {

  type = map(object({
    instance-type             = string
    name                      = string
    min-size                  = number
    desired-size              = number
    max-size                  = number
    k8s-labels                = map(string)
  }))
  description = "Configuration of the EKS managed node groups. Map of objects with node group name as the key."
}

################################
# IAM Roles - Service Accounts
################################

/*
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}
*/

variable "ami-versions" {}

