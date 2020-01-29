module "project_vpc" {
  source                 = "../../../../modules/services/project_vpc"
  aws_account_id         = var.aws_account_id
  cidr_block_host_octets = var.cidr_block_host_octets
  environment            = var.environment
  project                = var.project
  region                 = var.region
}