variable "environment" {
  description = "The type of environment (e.g. dev, qa, prod, etc.)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "subnet_name" {
  description = "subnet name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "availability_zone" {
  description = "AZ of subnet"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block of VPC, e.g. 172.30.0.0/16"
  type        = string
}

variable "is_external" {
  description = "Is an external (gateway) subnet"
  type        = bool
  default     = false
}