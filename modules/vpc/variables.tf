variable "project_name" {
  description = "Name prefix for tagging all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "IP range for the whole VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Specific AWS data center zone, e.g. ap-south-1a"
  type        = string
}