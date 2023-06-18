resource "aws_ec2_tag" "vpc_tag" {
  resource_id = var.vpc_id
  key         = format("kubernetes.io/cluster/%s","${var.cluster_name}-${var.env}")
  value       = "shared"
}

resource "aws_ec2_tag" "cluster_subnet_tag" {
  count       = length(var.private_subnets)
  resource_id = var.private_subnets[count.index]
  key         = format("kubernetes.io/cluster/%s", "${var.cluster_name}-${var.env}")
  value       = "shared"
}

resource "aws_ec2_tag" "private_subnet_tag" {
  count       = length(var.private_subnets)
  resource_id = var.private_subnets[count.index]
  key         = "kubernetes.io/role/elb"
  value       = "1"
}
