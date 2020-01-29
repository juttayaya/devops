module "project_vpc" {
  source                 = "../../../../modules/services/project_security_groups"
  aws_account_id         = var.aws_account_id
  environment            = var.environment
  project                = var.project
  region                 = var.region
}