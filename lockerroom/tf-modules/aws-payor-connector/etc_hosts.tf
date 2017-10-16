## Create dynamic /etc/hosts files
data "template_file" "etc_hosts" {
  template = "${file("${path.module}/etc_hosts.tpl")}"

  vars {
    payor00_ip = "${aws_instance.payor00.private_ip}"
    payor01_ip = "${aws_instance.payor01.private_ip}"
    connector01_ip = "${aws_instance.connector01.private_ip}"
    oracle01_ip = "${aws_instance.oracle01.private_ip}"
  }
}

resource "null_resource" "payor00_etc_hosts" {
  triggers {
      always = "uuid()"
  }
  connection {
    host = "${aws_instance.payor00.private_ip}"
    type = "ssh"
    user = "centos"
    private_key = "${file("/var/lib/jenkins/.aws/aws-us-east-2-pb.pem")}"
  }

  provisioner "file" {
    content = "${data.template_file.etc_hosts.rendered}"
    destination = "/tmp/etc_hosts"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/etc_hosts /etc/hosts",
      "ssh-keyscan ${aws_instance.payor01.private_ip} > /tmp/known_hosts",
      "sudo mv /tmp/known_hosts /home/weblogic/.ssh/known_hosts",
      "sudo chown weblogic. /home/weblogic/.ssh/known_hosts"
    ]
  }
}

resource "null_resource" "payor01_etc_hosts" {
  triggers {
      always = "uuid()"
  }
  connection {
    host = "${aws_instance.payor01.private_ip}"
    type = "ssh"
    user = "centos"
    private_key = "${file("/var/lib/jenkins/.aws/aws-us-east-2-pb.pem")}"
  }

  provisioner "file" {
    content = "${data.template_file.etc_hosts.rendered}"
    destination = "/tmp/etc_hosts"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/etc_hosts /etc/hosts"
    ]
  }
}

resource "null_resource" "connector01_etc_hosts" {
  triggers {
      always = "uuid()"
  }
  connection {
    host = "${aws_instance.connector01.private_ip}"
    type = "ssh"
    user = "centos"
    private_key = "${file("/var/lib/jenkins/.aws/aws-us-east-2-pb.pem")}"
  }

  provisioner "file" {
    content = "${data.template_file.etc_hosts.rendered}"
    destination = "/tmp/etc_hosts"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/etc_hosts /etc/hosts"
    ]
  }
}

