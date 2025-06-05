resource "aws_db_instance" "main" {
  identifier             = "multitenant-rds"
  engine                 = "sqlserver-se"
  instance_class         = "db.m5.large"
  allocated_storage      = 100
  username               = var.db_username
  password               = var.db_password
  multi_az               = true
  backup_retention_period = 7
  vpc_security_group_ids = [aws_security_group.database.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
  license_model          = "license-included"

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = aws_subnet.database[*].id
}