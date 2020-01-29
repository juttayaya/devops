resource "aws_subnet" "project" {
  availability_zone = var.availability_zone
  cidr_block        = var.cidr_block
  vpc_id            = var.vpc_id

  tags = {
    Name        = var.subnet_name
    project     = var.project
    environment = var.environment
    subnet-type = var.is_external ? "external" : "internal"
  }
}
