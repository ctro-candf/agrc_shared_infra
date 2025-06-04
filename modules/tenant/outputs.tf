# modules/tenant/outputs.tf - Tenant Outputs
output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "db_endpoint" {
  value = aws_db_instance.main.endpoint
}
