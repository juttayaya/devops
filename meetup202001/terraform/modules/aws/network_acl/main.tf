resource "aws_network_acl" "project" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  tags = {
    Name        = var.network_acl_name
    project     = var.project
    environment = var.environment
  }
}
