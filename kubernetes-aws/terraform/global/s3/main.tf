terraform {
  backend "s3" {
    bucket = "jirawat-kubectl-io-terraform-state"
    region = "us-east-2"
    key = "global/s3/terraform.tfstate"
    dynamodb_table = "jirawat-kubectl-io-terraform-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "jirawat-kubectl-io-state-store" {
    bucket = "jirawat-kubectl-io-state-store"
    acl = "private"

    versioning {
      enabled = false
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "Kubernetes State for jirawat.kubectl.io"
      Org = "jirawat.com"
      Project = "kubectl.io"
    }      
}

resource "aws_s3_bucket" "jirawat-kubectl-io-terraform-state" {
    bucket = "jirawat-kubectl-io-terraform-state"
    acl = "private"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "Terraform State for jirawat.kubectl.io"
      Org = "jirawat.com"
      Project = "kubectl.io"
    }      
}
