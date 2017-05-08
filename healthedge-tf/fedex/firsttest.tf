provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "he-fedex" {
  ami = "ami-6d1c2007"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.he-sg.id}"]

  tags {
    Name = "healthedge-centos7"
  }
}

resource "aws_security_group" "he-sg" {
  name = "healthedge-centos7-instance"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


