resource "aws_route_table" "project" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.cidr_block
    gateway_id = var.gateway_id
  }

  tags = {
    Name        = var.route_table_name
    project     = var.project
    environment = var.environment
  }
}
