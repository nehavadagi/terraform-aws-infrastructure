output "db_endpoint" {
  description = "Database connection endpoint"
  value       = aws_db_instance.main.endpoint
}