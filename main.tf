# main.tf - Root Module
module "shared" {
  source                     = "./modules/shared"
  project_name               = var.project_name
  environment                = var.environment
  db_username                = var.db_username
  db_password                = var.db_password
  shared_vpc_cidr            = var.shared_vpc_cidr
  private_subnet_cidrs       = var.private_subnet_cidrs
  database_subnet_cidrs      = var.database_subnet_cidrs
}

module "tenant" {
  source                     = "./modules/tenant"
  project_name               = var.project_name
  tenant_name                = var.tenant_name
  environment                = var.environment
  instance_type              = var.instance_type
  min_size                   = 1
  max_size                   = 2
  desired_capacity           = 1
  vpc_cidr                   = "10.1.0.0/16"
  public_subnet_cidrs        = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs       = ["10.1.11.0/24", "10.1.12.0/24"]
  tgw_id                     = module.shared.tgw_id
  shared_vpc_cidr            = var.shared_vpc_cidr
}
