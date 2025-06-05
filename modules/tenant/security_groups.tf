resource "aws_security_group" "web" {
  name        = "${var.project_name}-${var.tenant_name}-web-sg"
  description = "Allow tenant EC2 to access RDS in shared VPC"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.tenant_name}-web-sg"
    Environment = var.environment
  }
}