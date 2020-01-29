resource "aws_internet_gateway" "project" {
  vpc_id = var.vpc_id

  tags = {
    Name        = var.igw_name
    project     = var.project
    environment = var.environment
  }
}
