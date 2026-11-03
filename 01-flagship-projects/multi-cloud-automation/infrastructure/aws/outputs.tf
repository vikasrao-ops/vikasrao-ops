output "aws_s3_bucket_name" {
  value       = aws_s3_bucket.bucket.id
  description = "Name of the AWS S3 Bucket."
}

