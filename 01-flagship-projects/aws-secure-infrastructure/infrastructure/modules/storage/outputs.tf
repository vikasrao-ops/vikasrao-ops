output "bucket_id" {
  value       = aws_s3_bucket.secure_bucket.id
  description = "The name of the S3 bucket."
}

output "bucket_arn" {
  value       = aws_s3_bucket.secure_bucket.arn
  description = "The ARN of the S3 bucket."
}

output "kms_key_arn" {
  value       = aws_kms_key.s3_key.arn
  description = "ARN of the customer-managed KMS key."
}

