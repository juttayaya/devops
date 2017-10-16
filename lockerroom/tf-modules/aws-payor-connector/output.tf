# ip-addresses
output "payor00-public-ip" {
  value = "${aws_instance.payor00.public_ip}"
}
output "payor00-private-ip" {
  value = "${aws_instance.payor00.private_ip}"
}
output "payor01-public-ip" {
  value = "${aws_instance.payor01.public_ip}"
}
output "payor01-private-ip" {
  value = "${aws_instance.payor01.private_ip}"
}
output "connector01-public-ip" {
  value = "${aws_instance.connector01.public_ip}"
}
output "connector01-private-ip" {
  value = "${aws_instance.connector01.private_ip}"
}

