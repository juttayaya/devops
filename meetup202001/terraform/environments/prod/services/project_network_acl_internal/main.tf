module "project_vpc" {
  source                 = "../../../../modules/services/project_network_acl_internal"
  aws_account_id         = var.aws_account_id
  environment            = var.environment
  project                = var.project
  region                 = var.region
}