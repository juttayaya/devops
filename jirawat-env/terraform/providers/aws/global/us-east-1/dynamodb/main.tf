variable "region"          { }
variable "tag_org"         { }
variable "tag_project"     { }

provider "aws" {
  region = "${var.region}"
}

resource "aws_dynamodb_table" "dynamodb-jirawat-devops-terraform-lock" {
  name = "jirawat-devops-terraform-lock"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "Terraform Lock Table for jirawat.com DevOps"
    Org = "${var.tag_org}"
    Project = "${var.tag_project}"
  }
}
 
