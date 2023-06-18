module "eks" {
  source = "../../modules/eks"

  cluster_name                         = var.cluster_name
  env                                  = var.env
  cluster_version                      = var.cluster_version
  vpc_id                               = var.vpc_id
  private_subnets                      = var.private_subnet
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  coredns_version                      = var.coredns_version
  kube_proxy_version                   = var.kube_proxy_version
  vpc_cni_version                      = var.vpc_cni_version
  default_tags                         = { name = "mb-dev" }
  manage_aws_auth_configmap            = false
  create_atlantis_role                 = false

}


 /* module "eks_addons" {
  source = "../../modules/eks_addons"
  cluster_name                         = var.cluster_name
  env                                  = var.env
  vpc_id                               = var.vpc_id
  eks_oidc_provider_arn                   = module.eks.eks_oidc_arn
  karpenter_iam_role_arn              =  module.eks.karpenter_iam_role_arn
  eks_cluster_endpoint                = module.eks.eks_cluster_endpoint
  karpenter_irsa_arn                  = module.eks.karpenter_irsa_arn
  karpenter_instance_profile_name     = module.eks.instance_profile_name
  karpenter_queue_name                = module.eks.karpenter_queue_name
  eks_cluster_certificate_authority_data = module.eks.eks_cluster_certificate_authority_data
  eks_cluster_id                      = module.eks.eks_cluster_id

  }  */