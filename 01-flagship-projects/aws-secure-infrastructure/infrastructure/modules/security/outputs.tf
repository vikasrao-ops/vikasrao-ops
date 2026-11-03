output "bastion_sg_id" {
  value       = aws_security_group.bastion.id
  description = "Security group ID for Bastion."
}

output "app_sg_id" {
  value       = aws_security_group.app.id
  description = "Security group ID for Application tier."
}

output "database_sg_id" {
  value       = aws_security_group.database.id
  description = "Security group ID for Database tier."
}

output "bastion_instance_profile_name" {
  value       = aws_iam_instance_profile.bastion_profile.name
  description = "IAM instance profile name for Bastion SSM access."
}

