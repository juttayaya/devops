###############
# VPC
###############
module "project_vpc" {
  source     = "../../aws/vpc"
  vpc_name = "${local.project_full_prefix}-vpc"
  cidr_block = "${var.cidr_block_host_octets}.0.0/16"
  environment = var.environment
  project = var.project
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
  environment = var.environment
  project = var.project
}

module "subnet_external_b" {
  source            = "../../aws/subnet"
  subnet_name       = "${local.project_full_prefix}-external-b"
  cidr_block        = "${var.cidr_block_host_octets}.2.0/24"
  availability_zone = "${var.region}b"
  is_external       = true
  vpc_id            = module.project_vpc.id
  environment = var.environment
  project = var.project
}

module "subnet_internal_a" {
  source            = "../../aws/subnet"
  subnet_name       = "${local.project_full_prefix}-internal-a"
  cidr_block        = "${var.cidr_block_host_octets}.10.0/24"
  availability_zone = "${var.region}a"
  is_external       = true
  vpc_id            = module.project_vpc.id
  environment = var.environment
  project = var.project
}

module "subnet_internal_b" {
  source            = "../../aws/subnet"
  subnet_name       = "${local.project_full_prefix}-internal-b"
  cidr_block        = "${var.cidr_block_host_octets}.20.0/24"
  availability_zone = "${var.region}b"
  is_external       = true
  vpc_id            = module.project_vpc.id
  environment = var.environment
  project = var.project
}

###############
# Internet Gateway
###############
module "app-igw" {
  source   = "../../aws/internet_gateway"
  igw_name = "${local.project_full_prefix}-igw"
  vpc_id   = module.project_vpc.id
  environment = var.environment
  project = var.project
}

###############
# Elastic IP
###############
//module "app-eip-nat-a" {
//  source   = "../../generic/network/eip"
//  eip-name = "${var.token}-eip-nat-a"
//  token    = var.token
//}
//
//module "app-eip-nat-b" {
//  source   = "../../generic/network/eip"
//  eip-name = "${var.token}-eip-nat-b"
//  token    = var.token
//}

###############
# NAT Gateways
###############
//module "app-nat-gw-a" {
//  source        = "../../generic/network/nat-gateway"
//  nat-gw-name   = "${var.token}-nat-gw-a"
//  allocation-id = module.app-eip-nat-a.id
//  subnet-id     = module.subnet-gateway-a.id
//  token         = var.token
//}
//
//module "app-nat-gw-b" {
//  source        = "../../generic/network/nat-gateway"
//  nat-gw-name   = "${var.token}-nat-gw-b"
//  allocation-id = module.app-eip-nat-b.id
//  subnet-id     = module.subnet-gateway-b.id
//  token         = var.token
//}

###############
# External Route Tables
###############
//module "app-external-route-table" {
//  source           = "../../generic/network/external-route-table"
//  route-table-name = "${var.token}-external-rt"
//  gateway-id       = module.app-igw.id
//  token            = var.token
//  vpc-id           = module.app-vpc.id
//}
//resource "aws_route_table_association" "app-external-rt-assoc-gw-a" {
//  subnet_id      = module.subnet-gateway-a.id
//  route_table_id = module.app-external-route-table.id
//}
//resource "aws_route_table_association" "app-external-rt-assoc-gw-b" {
//  subnet_id      = module.subnet-gateway-b.id
//  route_table_id = module.app-external-route-table.id
//}
//
//###############
//# NAT Route Tables
//###############
//#### Route Tables: nat-rt-a
//module "app-nat-route-table-a" {
//  source           = "../../generic/network/nat-route-table"
//  route-table-name = "${var.token}-nat-rt-a"
//  nat-gateway-id   = module.app-nat-gw-a.id
//  token            = var.token
//  vpc-id           = module.app-vpc.id
//}
//resource "aws_route_table_association" "app-nat-rt-assoc-db-a" {
//  subnet_id      = module.subnet-database-a.id
//  route_table_id = module.app-nat-route-table-a.id
//}
//resource "aws_route_table_association" "app-nat-rt-assoc-vtracks-a" {
//  subnet_id      = module.subnet-vtracks-a.id
//  route_table_id = module.app-nat-route-table-a.id
//}
//resource "aws_route_table_association" "app-nat-rt-assoc-workers-a" {
//  subnet_id      = module.subnet-workers-a.id
//  route_table_id = module.app-nat-route-table-a.id
//}
//
//#### Route Tables: nat-rt-b
//module "app-nat-route-table-b" {
//  source           = "../../generic/network/nat-route-table"
//  route-table-name = "${var.token}-nat-rt-b"
//  nat-gateway-id   = module.app-nat-gw-b.id
//  token            = var.token
//  vpc-id           = module.app-vpc.id
//}
//resource "aws_route_table_association" "app-nat-rt-assoc-db-b" {
//  subnet_id      = module.subnet-database-b.id
//  route_table_id = module.app-nat-route-table-b.id
//}
//resource "aws_route_table_association" "app-nat-rt-assoc-vtracks-b" {
//  subnet_id      = module.subnet-vtracks-b.id
//  route_table_id = module.app-nat-route-table-b.id
//}
//resource "aws_route_table_association" "app-nat-rt-assoc-workers-b" {
//  subnet_id      = module.subnet-workers-b.id
//  route_table_id = module.app-nat-route-table-b.id
//}
//
//###############
//# VPC Endpoints
//###############
//module "app-vpc-endpoint-s3" {
//  source = "../../generic/network/vpc-endpoint-s3"
//
//  vpc-endpoint-name = "${var.token}-endpoint-s3"
//  region = var.region
//  route_table_ids = [module.app-nat-route-table-a.id , module.app-nat-route-table-b.id]
//  token = var.token
//  vpc-id = module.app-vpc.id
//}
