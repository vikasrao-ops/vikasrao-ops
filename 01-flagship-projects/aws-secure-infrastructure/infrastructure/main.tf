# Module 1: Multi-AZ VPC with Public, Private, and Isolated Database Subnets
module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  environment  = var.environment
}

# Module 2: Security Groups & IAM Least-Privilege SSM Profiles
module "security" {
  source       = "./modules/security"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  environment  = var.environment
}

# Module 3: Hardened Compute (Bastion Host with SSM Session Manager)
module "compute" {
  source            = "./modules/compute"
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security.bastion_sg_id
  instance_profile  = module.security.bastion_instance_profile_name
  project_name      = var.project_name
  environment       = var.environment
}

# Module 4: Secure Object Storage (S3 with KMS CMK & Public Access Block)
module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
  environment  = var.environment
}

