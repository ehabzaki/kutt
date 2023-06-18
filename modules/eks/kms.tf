#tfsec:ignore:aws-kms-auto-rotate-keys
resource "aws_kms_key" "kms_key" {
  description = "Private Information Vault Master Key"

  tags = var.default_tags
}
