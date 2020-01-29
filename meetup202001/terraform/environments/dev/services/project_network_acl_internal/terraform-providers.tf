terraform {
  required_version = "~> 0.12.19"
  required_providers {
    aws = "~> 2.31"
  }
  backend "s3" {
    bucket         = "jirawat-devops202001-terraform-tfstate"
    region         = "us-east-1"
    key            = "environments/dev/project_network_acl_internal/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "jirawat-devops202001-terraform-tflock"
  }
}

provider "aws" {
  region = "us-east-1"
}