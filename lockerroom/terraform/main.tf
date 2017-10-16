variable "payor00_ip"       { }
variable "payor01_ip"       { }
variable "connector01_ip"   { }
variable "oracle01_ip"      { }
variable "envname"          { }

module "ci-59" {
    source = "../tf-modules/aws-payor-connector"
    envname = "${var.envname}"
    payor00_ip = "${var.payor00_ip}"
    payor01_ip = "${var.payor01_ip}"
    connector01_ip = "${var.connector01_ip}"
    oracle01_ip    = "${var.oracle01_ip}"
}
