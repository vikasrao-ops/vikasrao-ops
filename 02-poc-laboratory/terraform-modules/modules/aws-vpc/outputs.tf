output "vpc_id" {
  value       = aws_vpc.this.id
  description = "Created VPC ID."
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "IDs of the created public subnets."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "Created Internet Gateway ID."
}

