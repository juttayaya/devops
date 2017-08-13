terraform {
  backend "s3" {
    bucket = "jirawat-kubectl-io-terraform-state"
    region = "us-east-2"
    key = "global/dynamodb/terraform.tfstate"
    dynamodb_table = "jirawat-kubectl-io-terraform-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_dynamodb_table" "dynamodb-jirawat-kubectl-io-terraform-lock" {
  name = "jirawat-kubectl-io-terraform-lock"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "Terraform Lock Table for jirawat.kubectl.io"
    Org = "jirawat.com"
    Project = "kubectl.io"
  }
}
 
