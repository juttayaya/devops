variable "environment" {
  description = "The type of environment (e.g. dev, qa, prod, etc.)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "sg_name" {
  description = "security group name"
  type        = string
}

variable "sg_description" {
  description = "security group description"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}
