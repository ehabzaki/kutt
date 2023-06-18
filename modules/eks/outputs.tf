output "eks_oidc_arn" {
  value = module.eks.oidc_provider_arn
}

output "eks_oidc_issuer" {
  value = module.eks.cluster_oidc_issuer_url
}

output "eks_cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "eks_cluster_version" {
  value = module.eks.cluster_version
}

output "eks_cluster_primary_security_group_id" {
  value = module.eks.cluster_primary_security_group_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}
  
output "karpenter_iam_role_arn" {
  value = module.eks.eks_managed_node_groups["karpenter"].iam_role_arn
} 
output "karpenter_irsa_arn" {
  value = module.karpenter.irsa_arn
}
output "instance_profile_name" {
  value = module.karpenter.instance_profile_name
} 

 output "karpenter_queue_name" {
  value = module.karpenter.queue_name
} 