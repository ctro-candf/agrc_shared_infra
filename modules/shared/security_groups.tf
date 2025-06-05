resource "aws_security_group" "database" {
  name        = "${var.project_name}-database-sg"
  description = "Allow access to RDS from tenant VPCs"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.tenant_vpc_cidrs
    content {
      description     = "Allow SQL Server from tenant"
      from_port       = 1433
      to_port         = 1433
      protocol        = "tcp"
      cidr_blocks     = [ingress.value]
    }
  }

  tags = {
    Name        = "${var.project_name}-database-sg"
    Environment = var.environment
  }
}