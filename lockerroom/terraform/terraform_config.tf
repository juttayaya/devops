terraform {
  backend "s3" {
    bucket = "healthedge-terraform-state-us-east-2"
    region = "us-east-2"
    key = "jenkins/pb-ci-510/terraform.tfstate"
    dynamodb_table = "terraform_lock"
    encrypt = "true"
  }
}
