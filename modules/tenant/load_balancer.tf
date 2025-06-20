# Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.project_name}-${var.tenant_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id
  
  enable_deletion_protection = var.enable_deletion_protection
  
  tags = {
    Name        = "${var.project_name}-${var.tenant_name}-alb"
    Environment = var.environment
  }
}

# Target Group
resource "aws_lb_target_group" "web" {
  name     = "${var.project_name}-${var.tenant_name}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tenant.id
  
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  
  tags = {
    Name        = "${var.project_name}-${var.tenant_name}-web-tg"
    Environment = var.environment
  }
}

# ALB Listener
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}