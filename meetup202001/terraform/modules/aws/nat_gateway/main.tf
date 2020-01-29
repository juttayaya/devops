resource "aws_nat_gateway" "project" {
  allocation_id = var.allocation_id
  subnet_id     = var.subnet_id

  tags = {
    Name        = var.nat_gateway_name
    project     = var.project
    environment = var.environment
  }
}
