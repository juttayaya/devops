provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "healthedge-sg-ssh" {
  name = "healthedge-sg-ssh"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

## VM definition
resource "aws_instance" "healthedge01" {
  ami = "ami-6d1c2007"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.healthedge-sg-ssh.id}"]
#  key_name = "he-keypair"

}

output "healthedge01_ip" {
  value = "${aws_instance.healthedge01.public_ip}"
}


