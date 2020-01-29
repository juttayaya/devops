variable "environment" {
  description = "The type of environment (e.g. dev, qa, prod, etc.)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "igw_name" {
  description = "Internet Gateway name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
