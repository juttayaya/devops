terraform {
  required_version = "~> 0.12.19"
  required_providers {
    aws = "~> 2.31"
  }
}

provider "aws" {
  region = var.region
}