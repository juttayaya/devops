###################
# Security Groups
###################
#### SG: SSH ingress access
module "sg_ssh" {
  source         = "../../aws/security_group"
  sg_name        = "${local.project_full_prefix}-sg-ssh"
  sg_description = "SSH ingress"
  vpc_id         = data.aws_vpc.project_vpc.id
  environment    = var.environment
  project        = var.project
}

resource "aws_security_group_rule" "sg_ssh_in_ssh" {
  description       = "ingress for SSH for external access"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.sg_ssh.id
}

#### SG: HTTP/S inbound access
module "sg_https" {
  source         = "../../aws/security_group"
  sg_name        = "${local.project_full_prefix}-sg-https"
  sg_description = "HTTP/S ingress"
  vpc_id         = data.aws_vpc.project_vpc.id
  environment    = var.environment
  project        = var.project
}

resource "aws_security_group_rule" "sg_https_in_http" {
  description       = "HTTP ingress"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.sg_https.id
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "sg_https_in_https" {
  description       = "HTTPS ingress"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = module.sg_https.id
  cidr_blocks       = ["0.0.0.0/0"]
}

#### SG: default egress access
module "sg_egress" {
  source         = "../../aws/security_group"
  sg_name        = "${local.project_full_prefix}-sg-egress"
  sg_description = "default egress"
  vpc_id         = data.aws_vpc.project_vpc.id
  environment    = var.environment
  project        = var.project
}

resource "aws_security_group_rule" "sg_egress_out_http" {
  description       = "HTTP egress"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.sg_egress.id
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "sg_egress_out_https" {
  description       = "HTTPS egress"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = module.sg_egress.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_egress_out_ntp" {
  description       = "NTP egress"
  type              = "egress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  security_group_id = module.sg_egress.id
  cidr_blocks       = ["0.0.0.0/0"]
}
