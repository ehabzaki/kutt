output "eks_oidc_arn" {
  value = module.eks.eks_oidc_arn
}

output "eks_oidc_issuer" {
  value = module.eks.eks_oidc_issuer
}

output "eks_cluster_security_group_id" {
  value = module.eks.eks_cluster_security_group_id
}

output "eks_cluster_id" {
  value = module.eks.eks_cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "karpenter_irsa_arn" {
  value = module.eks.karpenter_irsa_arn
}



/* output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
} */



