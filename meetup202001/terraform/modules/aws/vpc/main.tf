resource "aws_vpc" "project" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = var.vpc_name
    project     = var.project
    environment = var.environment
  }
}
