data "aws_iam_policy_document" "vpc_cni" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"
      values = [
        "system:serviceaccount:kube-system:aws-node"
      ]
    }
    principals {
      type        = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }
  }

  depends_on = [
    module.eks.aws_eks_cluster,
  ]
}

resource "aws_iam_role" "vpc_cni" {
  name               = "${var.cluster_name}-${var.env}-vpc-cni-role"
  assume_role_policy = data.aws_iam_policy_document.vpc_cni.json


  tags = var.default_tags

  depends_on = [
    module.eks.aws_eks_cluster,
  ]
}

resource "aws_iam_role_policy_attachment" "vpc_cni" {
  role       = aws_iam_role.vpc_cni.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
