###############
# Network ACL
###############
module "nacl_internal" {
  source           = "../../aws/network_acl"
  network_acl_name = "${local.project_full_prefix}-nacl-internal"
  vpc_id           = data.aws_vpc.project_vpc.id
  subnet_ids       = data.aws_subnet_ids.subnets_internal.ids
  project          = var.project
  environment      = var.environment
}

###############
# Network ACL: Inbound Rules
###############
resource "aws_network_acl_rule" "nacl_internal_rule_a_8080" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.subnet_external_a.cidr_block
  from_port      = 8080
  to_port        = 8080
}
resource "aws_network_acl_rule" "nacl_internal_rule_b_8080" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 101
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.subnet_external_a.cidr_block
  from_port      = 8080
  to_port        = 8080
}
resource "aws_network_acl_rule" "nacl_internal_rule_a_ssh" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 102
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.subnet_external_a.cidr_block
  from_port      = 22
  to_port        = 22
}
resource "aws_network_acl_rule" "nacl_internal_rule_b_ssh" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 103
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = data.aws_subnet.subnet_external_b.cidr_block
  from_port      = 22
  to_port        = 22
}
resource "aws_network_acl_rule" "nacl_internal_rule_a_denyall" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 108
  egress         = false
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = data.aws_subnet.subnet_external_a.cidr_block
  from_port      = 0
  to_port        = 65535
}
resource "aws_network_acl_rule" "nacl_internal_rule_b_denyall" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 109
  egress         = false
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = data.aws_subnet.subnet_external_b.cidr_block
  from_port      = 0
  to_port        = 65535
}

###############
# Network ACL: Outbound Rules
###############
resource "aws_network_acl_rule" "nacl_internal_rule_out_http" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 140
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}
resource "aws_network_acl_rule" "nacl_internal_rule_out_https" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 141
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}
resource "aws_network_acl_rule" "nacl_internal_rule_out_ntp" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 150
  egress         = true
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 123
  to_port        = 123
}

resource "aws_network_acl_rule" "nacl_internal_rule_out_deny-all" {
  network_acl_id = module.nacl_internal.id
  rule_number    = 32766
  egress         = false
  protocol       = "all"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = -1
  to_port        = -1
}
