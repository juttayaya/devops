terraform {
  backend "s3" {
    bucket = "terraform-s3-tfstate-example"
    region = "us-east-1"
    key = "example/ec2/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# Amazon Linux AMI
resource "aws_instance" "ec2-example" {
    count = 1
    ami = "ami-a4c7edb2"
    instance_type = "t2.micro"
    
    lifecycle {
      create_before_destroy = true
    }

    tags {
      Name = "Example for S3 tfstate"
      Org = "JavaJirawat"
    }      
}
