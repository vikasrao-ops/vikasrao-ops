output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the provisioned VPC."
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "IDs of the public subnets."
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "IDs of the private workload subnets."
}

output "database_subnet_ids" {
  value       = module.vpc.database_subnet_ids
  description = "IDs of the isolated database subnets."
}

output "bastion_instance_id" {
  value       = module.compute.bastion_instance_id
  description = "Instance ID of the Bastion host (accessible via SSM Session Manager)."
}

output "s3_bucket_name" {
  value       = module.storage.bucket_id
  description = "Hardened S3 Bucket with KMS customer-managed encryption."
}

