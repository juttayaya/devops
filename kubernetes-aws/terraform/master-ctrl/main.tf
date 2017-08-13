terraform {
  backend "s3" {
    bucket = "jirawat-kubectl-io-terraform-state"
    region = "us-east-2"
    key = "master-ctrl/terraform.tfstate"
    dynamodb_table = "jirawat-kubectl-io-terraform-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "master-ctrl-ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["aws-master-control-ami"]
  }
  filter {
    name   = "tag:Org"
    values = ["jirawat.com"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "master-ctrl" {
    ami = "${data.aws_ami.master-ctrl-ami.image_id}"
    instance_type = "t2.large"
    count = 1
    key_name = "k8s-keypair"
    
    lifecycle {
      create_before_destroy = true
    }

    tags {
      Name = "Master Control Server"
      Org = "jirawat.com"
    }      
}
