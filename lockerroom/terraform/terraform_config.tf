terraform {
  backend "s3" {
    bucket = "jirawat-terraform-state-us-east-2"
    region = "us-east-2"
    key = "lockerroom/terraform.tfstate"
    dynamodb_table = "terraform_lock"
    encrypt = "true"
  }
}
