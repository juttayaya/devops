###############
# VPC
###############
module "project_vpc" {
  source      = "../../aws/vpc"
  vpc_name    = "${local.project_full_prefix}-vpc"
  cidr_block  = "${var.cidr_block_host_octets}.0.0/16"
  environment = var.environment
  project     = var.project
}

###############
# Subnets
###############
module "subnet_external_a" {
  source            = "../../aws/subnet"
  subnet_name       = "${local.project_full_prefix}-external-a"
  cidr_block        = "${var.cidr_block_host_octets}.1.0/24"
  availability_zone = "${var.region}a"
  is_external       = true
  vpc_id            = module.project_vpc.id
  environment       = var.environment
  project           = var.project
}

module "subnet_external_b" {
  source            = "../../aws/subnet"
  subnet_name       = "${local.project_full_prefix}-external-b"
  cidr_block        = "${var.cidr_block_host_octets}.2.0/24"
  availability_zone = "${var.region}b"
  is_external       = true
  vpc_id            = module.project_vpc.id
  environment       = var.environment
  project           = var.project
}

module "subnet_internal_a" {
  source            = "../../aws/subnet"
  subnet_name       = "${local.project_full_prefix}-internal-a"
  cidr_block        = "${var.cidr_block_host_octets}.10.0/24"
  availability_zone = "${var.region}a"
  vpc_id            = module.project_vpc.id
  environment       = var.environment
  project           = var.project
}

module "subnet_internal_b" {
  source            = "../../aws/subnet"
  subnet_name       = "${local.project_full_prefix}-internal-b"
  cidr_block        = "${var.cidr_block_host_octets}.20.0/24"
  availability_zone = "${var.region}b"
  vpc_id            = module.project_vpc.id
  environment       = var.environment
  project           = var.project
}

###############
# Internet Gateway
###############
module "project_igw" {
  source      = "../../aws/internet_gateway"
  igw_name    = "${local.project_full_prefix}-igw"
  vpc_id      = module.project_vpc.id
  environment = var.environment
  project     = var.project
}

###############
# Elastic IP
###############
module "eip_internal_a" {
  source      = "../../aws/eip"
  eip_name    = "${local.project_full_prefix}-eip-internal-a"
  environment = var.environment
  project     = var.project
}

module "eip_internal_b" {
  source      = "../../aws/eip"
  eip_name    = "${local.project_full_prefix}-eip-internal-b"
  environment = var.environment
  project     = var.project
}

###############
# NAT Gateways
###############
module "nat_gateway_internal_a" {
  source           = "../../aws/nat_gateway"
  nat_gateway_name = "${local.project_full_prefix}-natgw-internal-a"
  allocation_id    = module.eip_internal_a.id
  subnet_id        = module.subnet_external_a.id
  environment      = var.environment
  project          = var.project
}

module "nat_gateway_internal_b" {
  source           = "../../aws/nat_gateway"
  nat_gateway_name = "${local.project_full_prefix}-natgw-internal-b"
  allocation_id    = module.eip_internal_b.id
  subnet_id        = module.subnet_external_b.id
  environment      = var.environment
  project          = var.project
}


###############
# External Route Tables
###############
module "vpc_route_table_external" {
  source           = "../../aws/vpc_route_table"
  route_table_name = "${local.project_full_prefix}-rt-external"
  gateway_id       = module.project_igw.id
  vpc_id           = module.project_vpc.id
  environment      = var.environment
  project          = var.project
}
resource "aws_route_table_association" "rt_external_assoc_a" {
  subnet_id      = module.subnet_external_a.id
  route_table_id = module.vpc_route_table_external.id
}
resource "aws_route_table_association" "rt_external_assoc_b" {
  subnet_id      = module.subnet_external_b.id
  route_table_id = module.vpc_route_table_external.id
}

###############
# NAT Route Tables
###############
#### Route Tables: rt-internal-a
module "vpc_route_table_internal_a" {
  source           = "../../aws/vpc_route_table"
  route_table_name = "${local.project_full_prefix}-rt-internal-a"
  gateway_id       = module.nat_gateway_internal_a.id
  vpc_id           = module.project_vpc.id
  environment      = var.environment
  project          = var.project
}
resource "aws_route_table_association" "rt_internal_assoc_a" {
  subnet_id      = module.subnet_internal_a.id
  route_table_id = module.vpc_route_table_internal_a.id
}

#### Route Tables: rt-internal-b
module "vpc_route_table_internal_b" {
  source           = "../../aws/vpc_route_table"
  route_table_name = "${local.project_full_prefix}-rt-internal-b"
  gateway_id       = module.nat_gateway_internal_b.id
  vpc_id           = module.project_vpc.id
  environment      = var.environment
  project          = var.project
}
resource "aws_route_table_association" "rt_internal_assoc_b" {
  subnet_id      = module.subnet_internal_b.id
  route_table_id = module.vpc_route_table_internal_b.id
}

