variable "cluster_name" {
  description = "(Required) cluster name"
  type        = string
}

variable "env" {
  description = "(Required) environment to deploy in"
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "(Required) environment to deploy in"
  type        = string
}
variable "eks_cluster_id" {
  description = "(Required) environment to deploy in"
  type        = string
}


variable "eks_cluster_certificate_authority_data" {
  description = "(Required) environment to deploy in"
  type        = string
}
variable "vpc_id" {
  description = "(Required) vpc id"
  type        = string
}

variable "karpenter_irsa_arn" {
  description = "(Required) vpc id"
  type        = string
}

variable "karpenter_instance_profile_name" {
  description = "(Required) vpc id"
  type        = string
}


variable "karpenter_queue_name" {
  description = "(Required) vpc id"
  type        = string
}

variable "karpenter_iam_role_arn" {
  description = "(Required) vpc id"
  type        = string
}

variable "eks_oidc_provider_arn" {
  description = "(Required) vpc id"
  type        = string
}

