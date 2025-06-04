# Database Security Group
resource "aws_security_group" "database" {
  name        = "${var.project_name}-database-sg"
  description = "Security group for RDS database"
  vpc_id      = aws_vpc.main.id
  
  ingress {
    description     = "MySQL/Aurora"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id] ## EDIT IT
  }
  
  tags = {
    Name        = "${var.project_name}-database-sg"
    Environment = var.environment
  }
}