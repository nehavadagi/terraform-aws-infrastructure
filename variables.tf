# ===== Project Variables =====
variable "project_name" {
  description = "Prefix used to name all resources"
  type        = string
}

variable "availability_zone" {
  description = "AWS availability zone to deploy into"
  type        = string
}

# ===== EC2 Variables =====
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your IP address in CIDR format for SSH access"
  type        = string
}

# ===== RDS Variables =====
variable "db_instance_class" {
  description = "RDS instance type (e.g., db.t3.micro, db.t3.small)"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name to create on the RDS instance"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS database"
  type        = string
  sensitive   = true
}