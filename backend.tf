terraform {
  required_version = ">= 1.5.0"
  cloud { 
    
    organization = "AGRC_infra" 

    workspaces { 
      name = "dev" 
    } 
  } 
}