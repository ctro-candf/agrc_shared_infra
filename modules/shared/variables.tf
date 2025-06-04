variable "project_name" {
  description = "Project identifier used for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the web servers"
  type        = string
  default     = "t3.micro"
}

variable "db_username" {
  description = "Master username for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS database"
  type        = string
  sensitive   = true
}

variable "shared_vpc_cidr" {
  description = "CIDR block for the shared VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# variable "public_subnet_cidrs" {
#   description = "List of CIDR blocks for public subnets"
#   type        = list(string)
#   default     = ["10.0.1.0/24", "10.0.2.0/24"]
# }

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  description = "List of CIDR blocks for database subnets"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}