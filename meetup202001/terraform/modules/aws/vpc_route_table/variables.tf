variable "environment" {
  description = "The type of environment (e.g. dev, qa, prod, etc.)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "route_table_name" {
  description = "Route Table name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block"
  type        = string
  default     = "0.0.0.0/0"
}

variable "gateway_id" {
  description = "External Internet Gateway ID"
  type        = string
}
