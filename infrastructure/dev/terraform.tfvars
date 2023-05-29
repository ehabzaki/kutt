# TAGS
cluster_name = "mb"
env   = "dev"

sg_karpenter_tags = {
  "karpenter.sh/discovery" = "mb-dev"
}

vpc_id = "vpc-03629511dcf741491"
private_subnet= ["subnet-05406e627004a5340", "subnet-0480152b65b118a52"]
# ROUTE53


# EKS

cluster_version    = "1.27"
coredns_version    = "v1.10.1-eksbuild.1"
kube_proxy_version = "v1.27.1-eksbuild.1"
vpc_cni_version    = "v1.12.6-eksbuild.2"

cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
