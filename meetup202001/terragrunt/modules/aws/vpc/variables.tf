variable "environment" {
  description = "The type of environment (e.g. dev, qa, prod, etc.)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block of VPC, e.g. 172.30.0.0/16"
  type        = string
}
