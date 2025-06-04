# Launch Template
resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-web-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  
  vpc_security_group_ids = [aws_security_group.web.id]
  
  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    db_endpoint = aws_db_instance.main.endpoint
  }))
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.project_name}-web-server"
      Environment = var.environment
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}