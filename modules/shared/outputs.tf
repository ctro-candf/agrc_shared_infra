# modules/shared/outputs.tf - Shared Outputs
output "vpc_id" {
  value = aws_vpc.main.id
}

output "database_subnets" {
  value = aws_subnet.database[*].id
}

output "tgw_id" {
  value = aws_ec2_transit_gateway.main.id
}