terraform {
  backend "s3" {
    bucket = "jirawat-devops-terraform-state"
    region = "us-east-1"
    key = "global/s3/terraform.tfstate"
    dynamodb_table = "jirawat-devops-terraform-lock"
    encrypt = true
  }
}
