variable "environment" {
  description = "The type of environment (e.g. dev, qa, prod, etc.)"
  type        = string
}

variable "region" {
  description = "The AWS region (e.g. us-east-1, us-west-2)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "cidr_block_host_octets" {
  description = "CIDR block host octets of VPC, e.g. 172.30 . The project VPC will have a mask of /16 , e.g. 172.30.0.0/16"
  type        = string
}
