variable "environment" {
  description = "The type of environment (e.g. dev, qa, prod, etc.)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "nat_gateway_name" {
  description = "NAT Gateway Name"
  type        = string
}

variable "allocation_id" {
  description = "NAT Elastic IP id"
  type        = string
}

variable "subnet_id" {
  description = "NAT Gateway subnet id"
  type        = string
}
