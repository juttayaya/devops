variable "region"          { }
variable "tag_org"         { }
variable "tag_project"     { }

provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "jirawat-devops-terraform-state" {
    bucket = "jirawat-devops-terraform-state"
    acl = "private"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "Terraform State for jirawat.com DevOps servers"
      Org = "${var.tag_org}"
      Project = "${var.tag_project}"
    }      

}
