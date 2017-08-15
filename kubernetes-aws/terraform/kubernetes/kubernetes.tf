output "bastion_security_group_ids" {
  value = ["${aws_security_group.bastion-jirawat-kubectl-io.id}"]
}

output "bastions_role_arn" {
  value = "${aws_iam_role.bastions-jirawat-kubectl-io.arn}"
}

output "bastions_role_name" {
  value = "${aws_iam_role.bastions-jirawat-kubectl-io.name}"
}

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
  value = ["${aws_subnet.us-east-2a-jirawat-kubectl-io.id}", "${aws_subnet.us-east-2b-jirawat-kubectl-io.id}", "${aws_subnet.us-east-2c-jirawat-kubectl-io.id}"]
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

resource "aws_autoscaling_attachment" "bastions-jirawat-kubectl-io" {
  elb                    = "${aws_elb.bastion-jirawat-kubectl-io.id}"
  autoscaling_group_name = "${aws_autoscaling_group.bastions-jirawat-kubectl-io.id}"
}

resource "aws_autoscaling_attachment" "master-us-east-2a-masters-jirawat-kubectl-io" {
  elb                    = "${aws_elb.api-jirawat-kubectl-io.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-2a-masters-jirawat-kubectl-io.id}"
}

resource "aws_autoscaling_attachment" "master-us-east-2b-masters-jirawat-kubectl-io" {
  elb                    = "${aws_elb.api-jirawat-kubectl-io.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-2b-masters-jirawat-kubectl-io.id}"
}

resource "aws_autoscaling_attachment" "master-us-east-2c-masters-jirawat-kubectl-io" {
  elb                    = "${aws_elb.api-jirawat-kubectl-io.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-2c-masters-jirawat-kubectl-io.id}"
}

resource "aws_autoscaling_group" "bastions-jirawat-kubectl-io" {
  name                 = "bastions.jirawat.kubectl.io"
  launch_configuration = "${aws_launch_configuration.bastions-jirawat-kubectl-io.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.utility-us-east-2a-jirawat-kubectl-io.id}", "${aws_subnet.utility-us-east-2b-jirawat-kubectl-io.id}", "${aws_subnet.utility-us-east-2c-jirawat-kubectl-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "bastions.jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Org"
    value               = "jirawat.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Project"
    value               = "kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/bastion"
    value               = "1"
    propagate_at_launch = true
  }
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
    key                 = "Org"
    value               = "jirawat.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Project"
    value               = "kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "master-us-east-2b-masters-jirawat-kubectl-io" {
  name                 = "master-us-east-2b.masters.jirawat.kubectl.io"
  launch_configuration = "${aws_launch_configuration.master-us-east-2b-masters-jirawat-kubectl-io.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-2b-jirawat-kubectl-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-2b.masters.jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Org"
    value               = "jirawat.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Project"
    value               = "kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "master-us-east-2c-masters-jirawat-kubectl-io" {
  name                 = "master-us-east-2c.masters.jirawat.kubectl.io"
  launch_configuration = "${aws_launch_configuration.master-us-east-2c-masters-jirawat-kubectl-io.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-2c-jirawat-kubectl-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-2c.masters.jirawat.kubectl.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Org"
    value               = "jirawat.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Project"
    value               = "kubectl.io"
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
  max_size             = 3
  min_size             = 3
  vpc_zone_identifier  = ["${aws_subnet.us-east-2a-jirawat-kubectl-io.id}", "${aws_subnet.us-east-2b-jirawat-kubectl-io.id}", "${aws_subnet.us-east-2c-jirawat-kubectl-io.id}"]

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
    key                 = "Org"
    value               = "jirawat.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Project"
    value               = "kubectl.io"
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
    Org                  = "jirawat.com"
    Project              = "kubectl.io"
    "k8s.io/etcd/events" = "a/a,b,c"
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
    Org                  = "jirawat.com"
    Project              = "kubectl.io"
    "k8s.io/etcd/main"   = "a/a,b,c"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_ebs_volume" "b-etcd-events-jirawat-kubectl-io" {
  availability_zone = "us-east-2b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "jirawat.kubectl.io"
    Name                 = "b.etcd-events.jirawat.kubectl.io"
    Org                  = "jirawat.com"
    Project              = "kubectl.io"
    "k8s.io/etcd/events" = "b/a,b,c"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_ebs_volume" "b-etcd-main-jirawat-kubectl-io" {
  availability_zone = "us-east-2b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "jirawat.kubectl.io"
    Name                 = "b.etcd-main.jirawat.kubectl.io"
    Org                  = "jirawat.com"
    Project              = "kubectl.io"
    "k8s.io/etcd/main"   = "b/a,b,c"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_ebs_volume" "c-etcd-events-jirawat-kubectl-io" {
  availability_zone = "us-east-2c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "jirawat.kubectl.io"
    Name                 = "c.etcd-events.jirawat.kubectl.io"
    Org                  = "jirawat.com"
    Project              = "kubectl.io"
    "k8s.io/etcd/events" = "c/a,b,c"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_ebs_volume" "c-etcd-main-jirawat-kubectl-io" {
  availability_zone = "us-east-2c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "jirawat.kubectl.io"
    Name                 = "c.etcd-main.jirawat.kubectl.io"
    Org                  = "jirawat.com"
    Project              = "kubectl.io"
    "k8s.io/etcd/main"   = "c/a,b,c"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_eip" "us-east-2a-jirawat-kubectl-io" {
  vpc = true
}

resource "aws_eip" "us-east-2b-jirawat-kubectl-io" {
  vpc = true
}

resource "aws_eip" "us-east-2c-jirawat-kubectl-io" {
  vpc = true
}

resource "aws_elb" "api-jirawat-kubectl-io" {
  name = "api-jirawat-kubectl-io-n6bm64"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-jirawat-kubectl-io.id}"]
  subnets         = ["${aws_subnet.utility-us-east-2a-jirawat-kubectl-io.id}", "${aws_subnet.utility-us-east-2b-jirawat-kubectl-io.id}", "${aws_subnet.utility-us-east-2c-jirawat-kubectl-io.id}"]

  health_check = {
    target              = "TCP:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "api.jirawat.kubectl.io"
  }
}

resource "aws_elb" "bastion-jirawat-kubectl-io" {
  name = "bastion-jirawat-kubectl-i-pe4a2m"

  listener = {
    instance_port     = 22
    instance_protocol = "TCP"
    lb_port           = 22
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.bastion-elb-jirawat-kubectl-io.id}"]
  subnets         = ["${aws_subnet.utility-us-east-2c-jirawat-kubectl-io.id}", "${aws_subnet.utility-us-east-2a-jirawat-kubectl-io.id}", "${aws_subnet.utility-us-east-2b-jirawat-kubectl-io.id}"]

  health_check = {
    target              = "TCP:22"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "bastion.jirawat.kubectl.io"
  }
}

resource "aws_iam_instance_profile" "bastions-jirawat-kubectl-io" {
  name = "bastions.jirawat.kubectl.io"
  role = "${aws_iam_role.bastions-jirawat-kubectl-io.name}"
}

resource "aws_iam_instance_profile" "masters-jirawat-kubectl-io" {
  name = "masters.jirawat.kubectl.io"
  role = "${aws_iam_role.masters-jirawat-kubectl-io.name}"
}

resource "aws_iam_instance_profile" "nodes-jirawat-kubectl-io" {
  name = "nodes.jirawat.kubectl.io"
  role = "${aws_iam_role.nodes-jirawat-kubectl-io.name}"
}

resource "aws_iam_role" "bastions-jirawat-kubectl-io" {
  name               = "bastions.jirawat.kubectl.io"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_bastions.jirawat.kubectl.io_policy")}"
}

resource "aws_iam_role" "masters-jirawat-kubectl-io" {
  name               = "masters.jirawat.kubectl.io"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.jirawat.kubectl.io_policy")}"
}

resource "aws_iam_role" "nodes-jirawat-kubectl-io" {
  name               = "nodes.jirawat.kubectl.io"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.jirawat.kubectl.io_policy")}"
}

resource "aws_iam_role_policy" "bastions-jirawat-kubectl-io" {
  name   = "bastions.jirawat.kubectl.io"
  role   = "${aws_iam_role.bastions-jirawat-kubectl-io.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_bastions.jirawat.kubectl.io_policy")}"
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

resource "aws_launch_configuration" "bastions-jirawat-kubectl-io" {
  name_prefix                 = "bastions.jirawat.kubectl.io-"
  image_id                    = "ami-ba0126df"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-jirawat-kubectl-io-3666ac2e35979542588b4d9db1a3420c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.bastions-jirawat-kubectl-io.id}"
  security_groups             = ["${aws_security_group.bastion-jirawat-kubectl-io.id}"]
  associate_public_ip_address = true

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 32
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "master-us-east-2a-masters-jirawat-kubectl-io" {
  name_prefix                 = "master-us-east-2a.masters.jirawat.kubectl.io-"
  image_id                    = "ami-ba0126df"
  instance_type               = "c4.large"
  key_name                    = "${aws_key_pair.kubernetes-jirawat-kubectl-io-3666ac2e35979542588b4d9db1a3420c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-jirawat-kubectl-io.id}"
  security_groups             = ["${aws_security_group.masters-jirawat-kubectl-io.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-2a.masters.jirawat.kubectl.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 70
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  placement_tenancy = "default"
}

resource "aws_launch_configuration" "master-us-east-2b-masters-jirawat-kubectl-io" {
  name_prefix                 = "master-us-east-2b.masters.jirawat.kubectl.io-"
  image_id                    = "ami-ba0126df"
  instance_type               = "c4.large"
  key_name                    = "${aws_key_pair.kubernetes-jirawat-kubectl-io-3666ac2e35979542588b4d9db1a3420c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-jirawat-kubectl-io.id}"
  security_groups             = ["${aws_security_group.masters-jirawat-kubectl-io.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-2b.masters.jirawat.kubectl.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 70
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  placement_tenancy = "default"
}

resource "aws_launch_configuration" "master-us-east-2c-masters-jirawat-kubectl-io" {
  name_prefix                 = "master-us-east-2c.masters.jirawat.kubectl.io-"
  image_id                    = "ami-ba0126df"
  instance_type               = "c4.large"
  key_name                    = "${aws_key_pair.kubernetes-jirawat-kubectl-io-3666ac2e35979542588b4d9db1a3420c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-jirawat-kubectl-io.id}"
  security_groups             = ["${aws_security_group.masters-jirawat-kubectl-io.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-2c.masters.jirawat.kubectl.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 70
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  placement_tenancy = "default"
}

resource "aws_launch_configuration" "nodes-jirawat-kubectl-io" {
  name_prefix                 = "nodes.jirawat.kubectl.io-"
  image_id                    = "ami-ba0126df"
  instance_type               = "m4.large"
  key_name                    = "${aws_key_pair.kubernetes-jirawat-kubectl-io-3666ac2e35979542588b4d9db1a3420c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-jirawat-kubectl-io.id}"
  security_groups             = ["${aws_security_group.nodes-jirawat-kubectl-io.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.jirawat.kubectl.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 70
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  placement_tenancy = "default"
}

resource "aws_nat_gateway" "us-east-2a-jirawat-kubectl-io" {
  allocation_id = "${aws_eip.us-east-2a-jirawat-kubectl-io.id}"
  subnet_id     = "${aws_subnet.utility-us-east-2a-jirawat-kubectl-io.id}"
}

resource "aws_nat_gateway" "us-east-2b-jirawat-kubectl-io" {
  allocation_id = "${aws_eip.us-east-2b-jirawat-kubectl-io.id}"
  subnet_id     = "${aws_subnet.utility-us-east-2b-jirawat-kubectl-io.id}"
}

resource "aws_nat_gateway" "us-east-2c-jirawat-kubectl-io" {
  allocation_id = "${aws_eip.us-east-2c-jirawat-kubectl-io.id}"
  subnet_id     = "${aws_subnet.utility-us-east-2c-jirawat-kubectl-io.id}"
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.jirawat-kubectl-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.jirawat-kubectl-io.id}"
}

resource "aws_route" "private-us-east-2a-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-east-2a-jirawat-kubectl-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-east-2a-jirawat-kubectl-io.id}"
}

resource "aws_route" "private-us-east-2b-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-east-2b-jirawat-kubectl-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-east-2b-jirawat-kubectl-io.id}"
}

resource "aws_route" "private-us-east-2c-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-east-2c-jirawat-kubectl-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-east-2c-jirawat-kubectl-io.id}"
}

resource "aws_route53_record" "api-jirawat-kubectl-io" {
  name = "api.jirawat.kubectl.io"
  type = "A"

  alias = {
    name                   = "${aws_elb.api-jirawat-kubectl-io.dns_name}"
    zone_id                = "${aws_elb.api-jirawat-kubectl-io.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z27TPEW6NYLT1J"
}

resource "aws_route53_record" "bastion-jirawat-kubectl-io" {
  name = "bastion.jirawat.kubectl.io"
  type = "A"

  alias = {
    name                   = "${aws_elb.bastion-jirawat-kubectl-io.dns_name}"
    zone_id                = "${aws_elb.bastion-jirawat-kubectl-io.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z27TPEW6NYLT1J"
}

resource "aws_route_table" "jirawat-kubectl-io" {
  vpc_id = "${aws_vpc.jirawat-kubectl-io.id}"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "jirawat.kubectl.io"
  }
}

resource "aws_route_table" "private-us-east-2a-jirawat-kubectl-io" {
  vpc_id = "${aws_vpc.jirawat-kubectl-io.id}"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "private-us-east-2a.jirawat.kubectl.io"
  }
}

resource "aws_route_table" "private-us-east-2b-jirawat-kubectl-io" {
  vpc_id = "${aws_vpc.jirawat-kubectl-io.id}"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "private-us-east-2b.jirawat.kubectl.io"
  }
}

resource "aws_route_table" "private-us-east-2c-jirawat-kubectl-io" {
  vpc_id = "${aws_vpc.jirawat-kubectl-io.id}"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "private-us-east-2c.jirawat.kubectl.io"
  }
}

resource "aws_route_table_association" "private-us-east-2a-jirawat-kubectl-io" {
  subnet_id      = "${aws_subnet.us-east-2a-jirawat-kubectl-io.id}"
  route_table_id = "${aws_route_table.private-us-east-2a-jirawat-kubectl-io.id}"
}

resource "aws_route_table_association" "private-us-east-2b-jirawat-kubectl-io" {
  subnet_id      = "${aws_subnet.us-east-2b-jirawat-kubectl-io.id}"
  route_table_id = "${aws_route_table.private-us-east-2b-jirawat-kubectl-io.id}"
}

resource "aws_route_table_association" "private-us-east-2c-jirawat-kubectl-io" {
  subnet_id      = "${aws_subnet.us-east-2c-jirawat-kubectl-io.id}"
  route_table_id = "${aws_route_table.private-us-east-2c-jirawat-kubectl-io.id}"
}

resource "aws_route_table_association" "utility-us-east-2a-jirawat-kubectl-io" {
  subnet_id      = "${aws_subnet.utility-us-east-2a-jirawat-kubectl-io.id}"
  route_table_id = "${aws_route_table.jirawat-kubectl-io.id}"
}

resource "aws_route_table_association" "utility-us-east-2b-jirawat-kubectl-io" {
  subnet_id      = "${aws_subnet.utility-us-east-2b-jirawat-kubectl-io.id}"
  route_table_id = "${aws_route_table.jirawat-kubectl-io.id}"
}

resource "aws_route_table_association" "utility-us-east-2c-jirawat-kubectl-io" {
  subnet_id      = "${aws_subnet.utility-us-east-2c-jirawat-kubectl-io.id}"
  route_table_id = "${aws_route_table.jirawat-kubectl-io.id}"
}

resource "aws_security_group" "api-elb-jirawat-kubectl-io" {
  name        = "api-elb.jirawat.kubectl.io"
  vpc_id      = "${aws_vpc.jirawat-kubectl-io.id}"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "api-elb.jirawat.kubectl.io"
  }
}

resource "aws_security_group" "bastion-elb-jirawat-kubectl-io" {
  name        = "bastion-elb.jirawat.kubectl.io"
  vpc_id      = "${aws_vpc.jirawat-kubectl-io.id}"
  description = "Security group for bastion ELB"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "bastion-elb.jirawat.kubectl.io"
  }
}

resource "aws_security_group" "bastion-jirawat-kubectl-io" {
  name        = "bastion.jirawat.kubectl.io"
  vpc_id      = "${aws_vpc.jirawat-kubectl-io.id}"
  description = "Security group for bastion"

  tags = {
    KubernetesCluster = "jirawat.kubectl.io"
    Name              = "bastion.jirawat.kubectl.io"
  }
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

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-jirawat-kubectl-io.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-jirawat-kubectl-io.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-elb-jirawat-kubectl-io.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-to-master-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.bastion-jirawat-kubectl-io.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "bastion-to-node-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.bastion-jirawat-kubectl-io.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-jirawat-kubectl-io.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.api-elb-jirawat-kubectl-io.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
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

resource "aws_security_group_rule" "node-to-master-protocol-ipip" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "4"
}

resource "aws_security_group_rule" "node-to-master-tcp-1-4001" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.nodes-jirawat-kubectl-io.id}"
  from_port                = 1
  to_port                  = 4001
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

resource "aws_security_group_rule" "ssh-elb-to-bastion" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.bastion-jirawat-kubectl-io.id}"
  source_security_group_id = "${aws_security_group.bastion-elb-jirawat-kubectl-io.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "ssh-external-to-bastion-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.bastion-elb-jirawat-kubectl-io.id}"
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

resource "aws_subnet" "us-east-2b-jirawat-kubectl-io" {
  vpc_id            = "${aws_vpc.jirawat-kubectl-io.id}"
  cidr_block        = "172.20.64.0/19"
  availability_zone = "us-east-2b"

  tags = {
    KubernetesCluster                          = "jirawat.kubectl.io"
    Name                                       = "us-east-2b.jirawat.kubectl.io"
    "kubernetes.io/cluster/jirawat.kubectl.io" = "owned"
  }
}

resource "aws_subnet" "us-east-2c-jirawat-kubectl-io" {
  vpc_id            = "${aws_vpc.jirawat-kubectl-io.id}"
  cidr_block        = "172.20.96.0/19"
  availability_zone = "us-east-2c"

  tags = {
    KubernetesCluster                          = "jirawat.kubectl.io"
    Name                                       = "us-east-2c.jirawat.kubectl.io"
    "kubernetes.io/cluster/jirawat.kubectl.io" = "owned"
  }
}

resource "aws_subnet" "utility-us-east-2a-jirawat-kubectl-io" {
  vpc_id            = "${aws_vpc.jirawat-kubectl-io.id}"
  cidr_block        = "172.20.0.0/22"
  availability_zone = "us-east-2a"

  tags = {
    KubernetesCluster                          = "jirawat.kubectl.io"
    Name                                       = "utility-us-east-2a.jirawat.kubectl.io"
    "kubernetes.io/cluster/jirawat.kubectl.io" = "owned"
  }
}

resource "aws_subnet" "utility-us-east-2b-jirawat-kubectl-io" {
  vpc_id            = "${aws_vpc.jirawat-kubectl-io.id}"
  cidr_block        = "172.20.4.0/22"
  availability_zone = "us-east-2b"

  tags = {
    KubernetesCluster                          = "jirawat.kubectl.io"
    Name                                       = "utility-us-east-2b.jirawat.kubectl.io"
    "kubernetes.io/cluster/jirawat.kubectl.io" = "owned"
  }
}

resource "aws_subnet" "utility-us-east-2c-jirawat-kubectl-io" {
  vpc_id            = "${aws_vpc.jirawat-kubectl-io.id}"
  cidr_block        = "172.20.8.0/22"
  availability_zone = "us-east-2c"

  tags = {
    KubernetesCluster                          = "jirawat.kubectl.io"
    Name                                       = "utility-us-east-2c.jirawat.kubectl.io"
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
  backend "s3" {
    bucket = "jirawat-kubectl-io-terraform-state"
    region = "us-east-2"
    key = "kubernetes/terraform.tfstate"
    dynamodb_table = "jirawat-kubectl-io-terraform-lock"
    encrypt = true
  }
}
