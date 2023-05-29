variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}
variable "cluster_name" {
  description = "(Required) market code"
}

variable "env" {
  description = "(Required) environment to deploy in"
}

/* variable "azs" {
  description = "(Required) Avalability Zones"
  type        = list(any)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
} */

#EKS

variable "cluster_version" {
  description = "(Required) EKS cluster version"
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "(Required) list of cidr to allow access to kubernetes api"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}
variable "coredns_version" {
  description = "(Required) EKS addon coredns version"
}

variable "kube_proxy_version" {
  description = "(Required) EKS addon kube-proxy version"
}

variable "vpc_cni_version" {
  description = "(Required) EKS addon vpc-cni version"
}

variable "sg_karpenter_tags" {
  description = "(Optional) domain name for bastion"
}
variable "vpc_id" {
  description = "(Optional) domain name for bastion"
}

variable "private_subnet" {
  description = "(Optional) domain name for bastion"
}