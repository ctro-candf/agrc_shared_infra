# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.shared_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}

# Public Subnets
# resource "aws_subnet" "public" {
#   count = length(var.public_subnet_cidrs)
  
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.public_subnet_cidrs[count.index]
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   map_public_ip_on_launch = true
  
#   tags = {
#     Name        = "${var.project_name}-public-subnet-${count.index + 1}"
#     Environment = var.environment
#     Type        = "Public"
#   }
# }

# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
  tags = {
    Name        = "${var.project_name}-private-subnet-${count.index + 1}"
    Environment = var.environment
    Type        = "Private"
  }
}

# Database Subnets
resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
  tags = {
    Name        = "${var.project_name}-database-subnet-${count.index + 1}"
    Environment = var.environment
    Type        = "Database"
  }
}

# # Elastic IPs for NAT Gateways
# resource "aws_eip" "nat" {
#   count = length(var.public_subnet_cidrs)
  
#   domain = "vpc"
  
#   tags = {
#     Name        = "${var.project_name}-eip-${count.index + 1}"
#     Environment = var.environment
#   }
  
#   depends_on = [aws_internet_gateway.main]
# }

# # NAT Gateways
# resource "aws_nat_gateway" "main" {
#   count = length(var.public_subnet_cidrs)
  
#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = aws_subnet.public[count.index].id
  
#   tags = {
#     Name        = "${var.project_name}-nat-${count.index + 1}"
#     Environment = var.environment
#   }
  
#   depends_on = [aws_internet_gateway.main]
# }

# Transit Gateway
resource "aws_ec2_transit_gateway" "main" {
  description = "Central Transit Gateway"
  auto_accept_shared_attachments = "enable"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "shared" {
  subnet_ids         = aws_subnet.private[*].id
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.main.id
}