data "aws_vpc" "project_vpc" {
  tags = {
    Name        = "${local.project_full_prefix}-vpc"
    project     = var.project
    environment = var.environment
  }
}

data "aws_subnet_ids" "subnets_internal" {
  vpc_id = data.aws_vpc.project_vpc.id
  tags = {
    project     = var.project
    environment = var.environment
    subnet_type = "internal"
  }
}

data "aws_subnet" "subnet_external_a" {
  vpc_id = data.aws_vpc.project_vpc.id
  tags = {
    Name        = "${local.project_full_prefix}-external-a"
    project     = var.project
    environment = var.environment
    subnet_type = "external"
  }
}

data "aws_subnet" "subnet_external_b" {
  vpc_id = data.aws_vpc.project_vpc.id
  tags = {
    Name        = "${local.project_full_prefix}-external-b"
    project     = var.project
    environment = var.environment
    subnet_type = "external"
  }
}
