output "cluster_name" {
  value = "jirawat.kubectl.io"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-jirawat-kubectl-io.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-jirawat-kubectl-io.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-jirawat-kubectl-io.name}"
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-jirawat-kubectl-io.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-2a-jirawat-kubectl-io.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-jirawat-kubectl-io.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-jirawat-kubectl-io.name}"
}

output "region" {
  value = "us-east-2"
}

output "vpc_id" {
  value = "${aws_vpc.jirawat-kubectl-io.id}"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_autoscaling_group" "master-us-east-2a-masters-jirawat-kubectl-io" {
  name                 = "master-us-east-2a.masters.jirawat.kubectl.io"
  launch_configuration = "${aws_launch_configuration.master-us-east-2a-masters-jirawat-kubectl-io.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-2a-jirawat-kubectl-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-2a.masters.jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "nodes-jirawat-kubectl-io" {
  name                 = "nodes.jirawat.kubectl.io"
  launch_configuration = "${aws_launch_configuration.nodes-jirawat-kubectl-io.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-east-2a-jirawat-kubectl-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }
}

resource "aws_ebs_volume" "a-etcd-events-jirawat-kubectl-io" {
  availability_zone = "us-east-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "jirawat.kubectl.io"
    Name                 = "a.etcd-events.jirawat.kubectl.io"
    "k8s.io/etcd/events" = "a/a"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_ebs_volume" "a-etcd-main-jirawat-kubectl-io" {
  availability_zone = "us-east-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "jirawat.kubectl.io"
    Name                 = "a.etcd-main.jirawat.kubectl.io"
    "k8s.io/etcd/main"   = "a/a"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_iam_instance_profile" "masters-jirawat-kubectl-io" {
  name = "masters.jirawat.kubectl.io"
  role = "${aws_iam_role.masters-jirawat-kubectl-io.name}"
}

resource "aws_iam_instance_profile" "nodes-jirawat-kubectl-io" {
  name = "nodes.jirawat.kubectl.io"
  role = "${aws_iam_role.nodes-jirawat-kubectl-io.name}"
}

resource "aws_iam_role" "masters-jirawat-kubectl-io" {
  name               = "masters.jirawat.kubectl.io"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.jirawat.kubectl.io_policy")}"
}

resource "aws_iam_role" "nodes-jirawat-kubectl-io" {
  name               = "nodes.jirawat.kubectl.io"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.jirawat.kubectl.io_policy")}"
}

resource "aws_iam_role_policy" "masters-jirawat-kubectl-io" {
  name   = "masters.jirawat.kubectl.io"
  role   = "${aws_iam_role.masters-jirawat-kubectl-io.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.jirawat.kubectl.io_policy")}"
}

resource "aws_iam_role_policy" "nodes-jirawat-kubectl-io" {
  name   = "nodes.jirawat.kubectl.io"
  role   = "${aws_iam_role.nodes-jirawat-kubectl-io.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.jirawat.kubectl.io_policy")}"
}

resource "aws_internet_gateway" "jirawat-kubectl-io" {
  vpc_id = "${aws_vpc.jirawat-kubectl-io.id}"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "jirawat.kubectl.io"
  }
}

resource "aws_key_pair" "kubernetes-jirawat-kubectl-io-3666ac2e35979542588b4d9db1a3420c" {
  key_name   = "kubernetes.jirawat.kubectl.io-36:66:ac:2e:35:97:95:42:58:8b:4d:9d:b1:a3:42:0c"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.jirawat.kubectl.io-3666ac2e35979542588b4d9db1a3420c_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-2a-masters-jirawat-kubectl-io" {
  name_prefix                 = "master-us-east-2a.masters.jirawat.kubectl.io-"
  image_id                    = "ami-ba0126df"
  instance_type               = "c4.large"
  key_name                    = "${aws_key_pair.kubernetes-jirawat-kubectl-io-3666ac2e35979542588b4d9db1a3420c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-jirawat-kubectl-io.id}"
  security_groups             = ["${aws_security_group.masters-jirawat-kubectl-io.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-2a.masters.jirawat.kubectl.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "nodes-jirawat-kubectl-io" {
  name_prefix                 = "nodes.jirawat.kubectl.io-"
  image_id                    = "ami-ba0126df"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-jirawat-kubectl-io-3666ac2e35979542588b4d9db1a3420c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-jirawat-kubectl-io.id}"
  security_groups             = ["${aws_security_group.nodes-jirawat-kubectl-io.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.jirawat.kubectl.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.jirawat-kubectl-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.jirawat-kubectl-io.id}"
}

resource "aws_route_table" "jirawat-kubectl-io" {
  vpc_id = "${aws_vpc.jirawat-kubectl-io.id}"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "jirawat.kubectl.io"
  }
}

resource "aws_route_table_association" "us-east-2a-jirawat-kubectl-io" {
  subnet_id      = "${aws_subnet.us-east-2a-jirawat-kubectl-io.id}"
  route_table_id = "${aws_route_table.jirawat-kubectl-io.id}"
}

resource "aws_security_group" "masters-jirawat-kubectl-io" {
  name        = "masters.jirawat.kubectl.io"
  vpc_id      = "${aws_vpc.jirawat-kubectl-io.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "masters.jirawat.kubectl.io"
  }
}

resource "aws_security_group" "nodes-jirawat-kubectl-io" {
  name        = "nodes.jirawat.kubectl.io"
  vpc_id      = "${aws_vpc.jirawat-kubectl-io.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "nodes.jirawat.kubectl.io"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  from_port                = 1
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-2a-jirawat-kubectl-io" {
  vpc_id            = "${aws_vpc.jirawat-kubectl-io.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-2a"

  tags = {
    KubernetesCluster                          = "jirawat.kubectl.io"
    Name                                       = "us-east-2a.jirawat.kubectl.io"
    "kubernetes.io/cluster/jirawat.kubectl.io" = "owned"
  }
}

resource "aws_vpc" "jirawat-kubectl-io" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                          = "jirawat.kubectl.io"
    Name                                       = "jirawat.kubectl.io"
    "kubernetes.io/cluster/jirawat.kubectl.io" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "jirawat-kubectl-io" {
  domain_name         = "us-east-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "jirawat.kubectl.io"
  }
}

resource "aws_vpc_dhcp_options_association" "jirawat-kubectl-io" {
  vpc_id          = "${aws_vpc.jirawat-kubectl-io.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.jirawat-kubectl-io.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
