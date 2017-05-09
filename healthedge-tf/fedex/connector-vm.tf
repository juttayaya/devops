provider "aws" {
  region = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to use to build Connector VM"
  default = "ami-f64f3be0"
}

resource "aws_security_group" "he-sg" {
  name = "he-centos7-sg"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

## VM definition
resource "aws_instance" "connector01" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.he-sg.id}"]
  key_name = "he-keypair"

  tags {
    Name = "connector01"
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_instance" "connector02" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.he-sg.id}"]
  key_name = "he-keypair"

  tags {
    Name = "connector02"
  }

  lifecycle {
    create_before_destroy = true
  }

}

output "connector01_ip" {
  value = "${aws_instance.connector01.public_ip}"
}

output "connector02_ip" {
  value = "${aws_instance.connector02.public_ip}"
}


