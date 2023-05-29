
/* 

module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "v19.15.1"

  cluster_name                    = "${var.cluster_name}-${var.env}"
  irsa_oidc_provider_arn          = var.oidc_provider_arn
  iam_role_arn                    = var.karpenter_iam_role_arn
  irsa_name                       = "karpenter"
  queue_name                      = "karpenter"
  iam_role_name                   = "karpenter"
  create_iam_role                 = false
  iam_role_use_name_prefix        = false
  irsa_use_name_prefix            = false
  policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

} */


/* resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  chart               = "karpenter"
  version             = "v0.21.1"
  values     = [file("${path.module}/values.yaml")]
  set {
    name  = "settings.aws.clusterName"
    value = "${var.cluster_name}-${var.env}"
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = var.eks_cluster_endpoint
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.karpenter_irsa_arn
  }

  set {
    name  = "settings.aws.defaultInstanceProfile"
    value = var.karpenter_instance_profile_name
  }

  set {
    name  = "settings.aws.interruptionQueueName"
    value = var.karpenter_queue_name
  }
} */

/* resource "kubernetes_manifest" "karpenter_provisioner" {
  manifest = {
    "apiVersion" = "karpenter.sh/v1alpha5"
    "kind" = "Provisioner"
    "metadata" = {
      "name" = "default"
    }
    "spec" = {
      "limits" = {
        "resources" = {
          "cpu" = 1000
        }
      }
      "providerRef" = {
        "name" = "default"
      }
      "requirements" = [
        {
          "key" = "karpenter.sh/capacity-type"
          "operator" = "In"
          "values" = [
            "spot",
          ]
        },
      ]
      "ttlSecondsAfterEmpty" = 30
    }
  }
  depends_on = [ helm_release.karpenter ]
}


resource "kubernetes_manifest" "karpenter_node_template" {
  manifest = {
    "apiVersion" = "karpenter.k8s.aws/v1alpha1"
    "kind" = "AWSNodeTemplate"
    "metadata" = {
      "name" = "default"
    }
    "spec" = {
      "securityGroupSelector" = {
        "karpenter.sh/discovery" = "${var.cluster_name}-${var.env}"
      }
      "subnetSelector" = {
        "karpenter.sh/discovery" = "${var.cluster_name}-${var.env}"
      }
      "tags" = {
        "karpenter.sh/discovery" = "${var.cluster_name}-${var.env}"
      }
    }
  }
  depends_on = [ helm_release.karpenter ]
}  */






resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  chart               = "karpenter"
  version             = "v0.21.1"
  values     = [file("${path.module}/values.yaml")]
  set {
    name  = "settings.aws.clusterName"
    value = "${var.cluster_name}-${var.env}"
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = var.eks_cluster_endpoint
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.karpenter_irsa_arn
  }

  set {
    name  = "settings.aws.defaultInstanceProfile"
    value =  var.karpenter_instance_profile_name
  }

  set {
    name  = "settings.aws.interruptionQueueName"
    value = var.karpenter_queue_name
  }

} 
