resource "aws_security_group" "web" {
  name        = "${var.project_name}-${var.tenant_name}-web-sg"
  description = "Allow tenant EC2 to access RDS in shared VPC"
  vpc_id      = aws_vpc.tenant.id

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

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.tenant_name}-alb-sg"
  description = "Allow HTTP traffic from internet to ALB"
  vpc_id      = aws_vpc.tenant.id

  ingress {
    description      = "Allow HTTP from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.tenant_name}-alb-sg"
    Environment = var.environment
  }
}