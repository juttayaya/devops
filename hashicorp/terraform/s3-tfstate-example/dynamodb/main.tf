provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "dynamodb-terraform-lock-example" {
  name = "terraform-lock-example"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "Terraform Lock Table Example"
    Org = "JavaJirawat"
  }
}
 
