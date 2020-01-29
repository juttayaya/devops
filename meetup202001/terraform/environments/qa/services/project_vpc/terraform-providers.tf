terraform {
  required_version = "~> 0.12.19"
  required_providers {
    aws = "~> 2.31"
  }
  backend "s3" {
    bucket         = "jirawat-devops202001-terraform-tfstate"
    region         = "us-east-1"
    key            = "environments/qa/project_vpc/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "jirawat-devops202001-terraform-tflock"
  }
}

provider "aws" {
  region = var.region
}