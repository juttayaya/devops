resource "aws_eip" "project" {
  vpc = true

  tags = {
    Name        = var.eip_name
    project     = var.project
    environment = var.environment
  }
}
