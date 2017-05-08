provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "he-fedex" {
  ami = "ami-6d1c2007"
  instance_type = "t2.micro"

  tags {
    Name = "healthedge-centos7"
  }
}

