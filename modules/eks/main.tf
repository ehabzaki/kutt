module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "v18.31.2"

  cluster_name                    = "${var.cluster_name}-${var.env}"
  cluster_version                 = var.cluster_version
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.private_subnets
  cluster_endpoint_private_access = true
  enable_irsa                     = true
  manage_aws_auth_configmap       = var.manage_aws_auth_configmap
  aws_auth_roles                  = var.aws_auth_roles
  create_node_security_group      = false

  prefix_separator                     = var.prefix_separator
  iam_role_name                        = var.iam_role_name
  cluster_security_group_description   = var.cluster_security_group_description
  cluster_security_group_name          = try(var.cluster_security_group_name, null)
  iam_role_arn                         = try(var.iam_role_name, null)
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_encryption_config = [
    {
      provider_key_arn = coalesce(var.cluster_encryption_kms_key, aws_kms_key.kms_key.arn)
      resources        = ["secrets"]
    }
  ]

  eks_managed_node_groups = {
    karpenter = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = var.nodes_instance_types
      capacity_type  = var.capacity_type
      disk_size      = var.node_disk_size
      ami_type       = "AL2_x86_64"

      cluster_version = coalesce(var.managed_node_groups_cluster_version, var.cluster_version)

      attach_cluster_primary_security_group = true

      iam_role_additional_policies = concat([
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ], var.iam_role_additional_policies)

      pre_bootstrap_user_data = <<-EOT
        #!/bin/bash
        set -ex
        cat <<-EOF > /etc/profile.d/bootstrap.sh
        export CONTAINER_RUNTIME="containerd"
        EOF
        # Source extra environment variables in bootstrap script
        sed -i '/^set -o errexit/a\\nsource /etc/profile.d/bootstrap.sh' /etc/eks/bootstrap.sh
      EOT
    }
  }

  tags = merge(
    var.default_tags,
    {
      "karpenter.sh/discovery" = "${var.cluster_name}-${var.env}"
    }
  )
}

resource "aws_eks_addon" "core_dns" {
  cluster_name      = module.eks.cluster_id
  addon_name        = "coredns"
  addon_version     = var.coredns_version
  resolve_conflicts_on_update = "OVERWRITE"

  tags = merge(
    var.default_tags,
    {
      "addon_name" = "coredns"
    },
  )

  depends_on = [
    module.eks.aws_eks_cluster
  ]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = module.eks.cluster_id
  addon_name        = "kube-proxy"
  addon_version     = var.kube_proxy_version
  resolve_conflicts_on_update = "OVERWRITE"

  tags = merge(
    var.default_tags,
    {
      "addon_name" = "kube-proxy"
    },
  )

  depends_on = [
    module.eks.aws_eks_cluster
  ]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name             = module.eks.cluster_id
  addon_name               = "vpc-cni"
  addon_version            = var.vpc_cni_version
  resolve_conflicts_on_update        = "OVERWRITE"
  service_account_role_arn = aws_iam_role.vpc_cni.arn

  tags = merge(
    var.default_tags,
    {
      "addon_name" = "vpc-cni"
    },
  )

  depends_on = [
    module.eks.aws_eks_cluster,
    aws_iam_role.vpc_cni
  ]
}
