output "terraform_state_bucket_name" {
  value       = aws_s3_bucket.state_bucket.id
  description = "Name of the S3 state bucket."
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.state_locks.name
  description = "Name of the DynamoDB state locking table."
}

