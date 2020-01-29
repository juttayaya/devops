data "aws_vpc" "project_vpc" {
  tags = {
    Name        = "${local.project_full_prefix}-vpc"
    project     = var.project
    environment = var.environment
  }
}
