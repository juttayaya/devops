terraform {
  backend "s3" {
    bucket = "terraform-netflix-oss-tfstate"
    region = "us-east-2"
    key = "global/s3/terraform.tfstate"
    dynamodb_table = "terraform-netflix-oss-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "netflix-oss-tfstate" {
    bucket = "terraform-netflix-oss-tfstate"
    acl = "private"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "Terraform Netflix OSS tfstate"
      Org = "jirawat.com"
      Project = "Netflix OSS"
    }      
}

resource "aws_s3_bucket" "kubectl-io-state-store" {
    bucket = "kubectl-io-state-store"
    acl = "private"

    versioning {
      enabled = false
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "Kubernetes State for kubectl.io"
      Org = "jirawat.com"
      Project = "kubectl.io"
    }      
}
