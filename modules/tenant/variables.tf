variable "project_name" {
  description = "Name prefix used for tagging and naming AWS resources"
  type        = string
}

variable "tenant_name" {
  description = "Tenant identifier used in naming resources (fix typo if needed)"
  type        = string
}

variable "environment" {
  description = "Deployment environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances launched via Launch Template"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled on the ALB"
  type        = bool
  default     = false
}

variable "vpc_cidr" {
  description = "CIDR block for the tenant VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "tgw_id" {
  description = "Transit Gateway ID for VPC attachment and routing"
  type        = string
}

variable "shared_vpc_cidr" {
  description = "CIDR block for the shared VPC"
  type        = string
}