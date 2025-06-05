# Transit gateway attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tenant" {
  transit_gateway_id = var.tgw_id
  vpc_id             = aws_vpc.tenant.id
  subnet_ids         = aws_subnet.private[*].id
}

# Route to shared

resource "aws_route" "to_shared" {
  count = length(var.private_subnet_cidrs)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = var.shared_vpc_cidr
  transit_gateway_id     = var.tgw_id
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tenant.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
  }
}

# Private Route Tables
resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidrs)
  
  vpc_id = aws_vpc.tenant.id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }
  
  tags = {
    Name        = "${var.project_name}-private-rt-${count.index + 1}"
    Environment = var.environment
  }
}

# Route table associations
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)
  
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}