###############
# Network ACL
###############
module "nacl_external" {
  source           = "../../aws/network_acl"
  network_acl_name = "${local.project_full_prefix}-nacl_external"
  vpc_id           = data.aws_vpc.project_vpc.id
  subnet_ids       = data.aws_subnet_ids.subnets_external.ids
  environment      = var.environment
  project          = var.project
}

###############
# Network ACL: Inbound Rules
###############
resource "aws_network_acl_rule" "nacl_external_rule_http" {
  network_acl_id = module.nacl_external.id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}
resource "aws_network_acl_rule" "nacl_external_rule_https" {
  network_acl_id = module.nacl_external.id
  rule_number    = 121
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}
resource "aws_network_acl_rule" "nacl_external_rule_ssh" {
  network_acl_id = module.nacl_external.id
  rule_number    = 122
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}
resource "aws_network_acl_rule" "nacl_external_rule_ntp" {
  network_acl_id = module.nacl_external.id
  rule_number    = 150
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 123
  to_port        = 123
}
resource "aws_network_acl_rule" "nacl_external-rule-deny-all" {
  network_acl_id = module.nacl_external.id
  rule_number    = 32766
  egress         = false
  protocol       = "all"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = -1
  to_port        = -1
}

###############
# Network ACL: Outbound Rules
###############
resource "aws_network_acl_rule" "nacl_external_rule_out_http" {
  network_acl_id = module.nacl_external.id
  rule_number    = 140
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}
resource "aws_network_acl_rule" "nacl_external_rule_out_https" {
  network_acl_id = module.nacl_external.id
  rule_number    = 141
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}
resource "aws_network_acl_rule" "nacl_external_rule_out_ntp" {
  network_acl_id = module.nacl_external.id
  rule_number    = 150
  egress         = true
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 123
  to_port        = 123
}

resource "aws_network_acl_rule" "nacl_external_rule_out_deny-all" {
  network_acl_id = module.nacl_external.id
  rule_number    = 32766
  egress         = true
  protocol       = "all"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = -1
  to_port        = -1
}
