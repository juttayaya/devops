terraform {
  required_version = "~> 0.12.19"
  required_providers {
    aws = "~> 2.31"
  }

  # The details of the S3 backend are defined in terragrunt.hcl
  # If not using the terragrunt automatic S3 state bucket creation,
  # then comment the line below, terragrunt the project_tfstate S3 bucket, and
  # then uncomment to use
  backend "s3" {}
}

provider "aws" {
  region = var.region
}