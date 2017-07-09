provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3-tfstate-example" {
    bucket = "terraform-s3-tfstate-example"
    acl = "private"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "Terraform S3 tfstate Example"
      Org = "JavaJirawat"
    }      
}
