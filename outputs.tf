# ===== EC2 Outputs =====
output "ec2_public_ip" {
  description = "Public IP address of the EC2 web server"
  value       = module.ec2.public_ip
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

# ===== VPC Outputs =====
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

# ===== RDS Outputs =====
output "rds_endpoint" {
  description = "Database connection endpoint"
  value       = module.rds.db_endpoint
}