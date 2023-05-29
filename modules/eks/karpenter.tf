
module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "v18.31.2"

  cluster_name                    = module.eks.cluster_name
  irsa_oidc_provider_arn          = module.eks.oidc_provider_arn
  irsa_namespace_service_accounts = ["karpenter:karpenter"]
  create_iam_role                 = false
  iam_role_use_name_prefix        = false
  irsa_use_name_prefix            = false
  iam_role_arn                    = module.eks.eks_managed_node_groups["karpenter"].iam_role_arn
  irsa_name                       = "karpenter"
  queue_name                      = "karpenter"
  iam_role_name                   = "karpenter"
}