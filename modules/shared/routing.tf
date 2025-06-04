# Database Route Table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name        = "${var.project_name}-database-rt"
    Environment = var.environment
  }
}

# Route Table Associations
resource "aws_route_table_association" "database" {
  count = length(aws_subnet.database)
  
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}