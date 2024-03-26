output "db_instance_endpoint" {
 description = "RDS endpoint"
 value       = aws_db_instance.tpr-mariadb.endpoint
}