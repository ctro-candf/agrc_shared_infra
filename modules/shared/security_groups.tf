resource "aws_security_group" "database" {
  name        = "${var.project_name}-database-sg"
  description = "Security group for RDS access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow SQL Server from tenant EC2"
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = var.tenant_sg
  }

  tags = {
    Name        = "${var.project_name}-database-sg"
    Environment = var.environment
  }
}