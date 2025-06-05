# modules/tenant/outputs.tf - Tenant Outputs
output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "web_sg_id" {
  value       = aws_security_group.web.id
  description = "Security group ID of tenant web servers"
}