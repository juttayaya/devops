terraform {
  backend "s3" {
    bucket = "terraform-netflix-oss-tfstate"
    region = "us-east-2"
    key = "global/dynamodb/terraform.tfstate"
    dynamodb_table = "terraform-netflix-oss-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_dynamodb_table" "dynamodb-terraform-netflix-oss-lock" {
  name = "terraform-netflix-oss-lock"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "Terraform Lock Table"
    Org = "jirawat.com"
    Project = "Netflix OSS"
  }
}
 
