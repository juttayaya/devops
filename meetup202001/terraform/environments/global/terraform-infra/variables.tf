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
