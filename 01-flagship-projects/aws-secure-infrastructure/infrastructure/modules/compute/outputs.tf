output "bastion_instance_id" {
  value       = aws_instance.bastion.id
  description = "Instance ID of the Bastion host."
}

output "bastion_private_ip" {
  value       = aws_instance.bastion.private_ip
  description = "Private IP of the Bastion host."
}

