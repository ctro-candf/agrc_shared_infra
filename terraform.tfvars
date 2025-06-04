project_name        = "agrc"
environment         = "dev"

shared_vpc_cidr     = "10.0.0.0/16"

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

database_subnet_cidrs = [
  "10.0.21.0/24",
  "10.0.22.0/24"
]

tenant_name         = "tenant4"
instance_type       = "t3.micro"