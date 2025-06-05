variable "project_name" {}
variable "environment" {}
variable "db_username" {
    sensitive   = true
}
variable "db_password" {
    sensitive   = true
}
variable "shared_vpc_cidr" {}
variable "private_subnet_cidrs" {}
variable "database_subnet_cidrs" {}

variable "tenant_name" {}
variable "instance_type" {}

variable "aws_region" {}