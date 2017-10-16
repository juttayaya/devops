variable "payor00_ip"       { }
variable "payor01_ip"       { }
variable "connector01_ip"   { }
variable "oracle01_ip"      { }
variable "envname"          { }
variable "instance_type"    { default="t2.large" }
variable "oracle_instance_type"    { default="t2.xlarge" }
variable "region"           { default="us-east-2" }
variable "tag_team"         { default="Healthedge" }
variable "tag_project"      { default="Burlington DevOps"}
variable "keypair"          { default="burlington-devops-keypair" }
variable "subnet"           { default="subnet-934e33fa" }
variable "security_group_name"  { default="HE3-Corp-Allow" }

provider "aws" {
  region = "${var.region}"
  version = "~> 0.1"
}

provider "template" {
  version = "~> 0.1"
}
provider "null" {
  version = "~> 0.1"
}
  

data "aws_ami" "payor-connector-fresh-ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["he-centos-installer-base"]
  }
  filter {
    name   = "tag:Team"
    values = ["${var.tag_team}"]
  }
  filter {
    name   = "tag:Project"
    values = ["${var.tag_project}"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ami" "he-oracle-ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["he-centos-oracle"]
  }
  filter {
    name   = "tag:Team"
    values = ["${var.tag_team}"]
  }
  filter {
    name   = "tag:Project"
    values = ["${var.tag_project}"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_security_group" "payor-connector-sg" {
    name = "${var.security_group_name}"
}

resource "aws_instance" "oracle01" {
    private_ip = "${var.oracle01_ip}"
    ami = "${data.aws_ami.he-oracle-ami.image_id}"
    instance_type = "${var.oracle_instance_type}"
    key_name = "${var.keypair}"
    vpc_security_group_ids =  ["${data.aws_security_group.payor-connector-sg.id}"]
    subnet_id = "${var.subnet}"
    count = 1
    root_block_device {
      volume_size = "60"
      delete_on_termination =  true
    }

    user_data = "${file("${path.module}/userdata.sh")}"

    lifecycle {
      ignore_changes = ["ebs_block_device"]
      create_before_destroy = true
    }

    tags {
      Name = "${var.envname}-oracle01"
      Team = "${var.tag_team}"
      Project = "${var.tag_project}"
    }
}

resource "aws_instance" "payor00" {
    private_ip = "${var.payor00_ip}"
    ami = "${data.aws_ami.payor-connector-fresh-ami.image_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.keypair}"
    vpc_security_group_ids =  ["${data.aws_security_group.payor-connector-sg.id}"]
    subnet_id = "${var.subnet}" 
    count = 1
    root_block_device {
      volume_size = "60"
      delete_on_termination =  true
    }

    user_data = "${file("${path.module}/userdata.sh")}"   

    lifecycle {
      ignore_changes = ["ebs_block_device"]
      create_before_destroy = true
    }

    tags {
      Name = "${var.envname}-payor00"
      Team = "${var.tag_team}"
      Project = "${var.tag_project}"
    }
}

resource "aws_instance" "payor01" {
    private_ip = "${var.payor01_ip}"
    ami = "${data.aws_ami.payor-connector-fresh-ami.image_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.keypair}"
    vpc_security_group_ids =  ["${data.aws_security_group.payor-connector-sg.id}"]
    subnet_id = "${var.subnet}"
    count = 1
    root_block_device {
      volume_size = "60"
      delete_on_termination =  true
    }

    user_data = "${file("${path.module}/userdata.sh")}"   

    lifecycle {
      ignore_changes = ["ebs_block_device"]
      create_before_destroy = true
    }

    tags {
      Name = "${var.envname}-payor01"
      Team = "${var.tag_team}"
      Project = "${var.tag_project}"
    }
}

resource "aws_instance" "connector01" {
    private_ip = "${var.connector01_ip}"
    ami = "${data.aws_ami.payor-connector-fresh-ami.image_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.keypair}"
    vpc_security_group_ids =  ["${data.aws_security_group.payor-connector-sg.id}"]
    subnet_id = "${var.subnet}"
    count = 1
    root_block_device {
      volume_size = "60"
      delete_on_termination =  true
    }

    user_data = "${file("${path.module}/userdata.sh")}"   

    lifecycle {
      ignore_changes = ["ebs_block_device"]
      create_before_destroy = true
    }

    tags {
      Name = "${var.envname}-connector01"
      Team = "${var.tag_team}"
      Project = "${var.tag_project}"
    }
}

