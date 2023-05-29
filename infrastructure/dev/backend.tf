terraform {
  backend "s3" {
    bucket         = "mb-dev-terragrunt-state"
    key            = "development"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tf-lock-table"
  }
}