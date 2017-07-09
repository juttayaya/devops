terraform {
  backend "s3" {
    bucket = "terraform-s3-tfstate-example"
    region = "us-east-1"
    key = "example/ec2-with-locking/terraform.tfstate"
    dynamodb_table = "terraform-lock-example"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# Amazon Linux AMI
resource "aws_instance" "ec2-with-locking-example" {
    count = 1
    ami = "ami-a4c7edb2"
    instance_type = "t2.micro"
    
    lifecycle {
      create_before_destroy = true
    }

    tags {
      Name = "Example for DynamoDB lock"
      Org = "JavaJirawat"
    }      
}
