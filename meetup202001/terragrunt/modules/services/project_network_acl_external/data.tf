data "aws_vpc" "project_vpc" {
  tags = {
    Name        = "${local.project_full_prefix}-vpc"
    project     = var.project
    environment = var.environment
  }
}

data "aws_subnet_ids" "subnets_external" {
  vpc_id = data.aws_vpc.project_vpc.id
  tags = {
    project     = var.project
    environment = var.environment
    subnet-type = "external"
  }
}
