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
