# 1. AWS KMS Customer Managed Key (CMK)
resource "aws_kms_key" "s3_key" {
  description             = "KMS CMK for S3 bucket encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Name = "${var.project_name}-${var.environment}-kms-s3"
  }
}

resource "aws_kms_alias" "s3_key_alias" {
  name          = "alias/${var.project_name}-${var.environment}-s3-key"
  target_key_id = aws_kms_key.s3_key.key_id
}

# Random suffix for globally unique S3 bucket name
resource "random_string" "s3_suffix" {
  length  = 6
  special = false
  upper   = false
}

# 2. Hardened S3 Bucket
resource "aws_s3_bucket" "secure_bucket" {
  bucket        = "${var.project_name}-${var.environment}-data-${random_string.s3_suffix.result}"
  force_destroy = false

  tags = {
    Name       = "${var.project_name}-${var.environment}-data"
    Compliance = "CIS-Benchmark"
  }
}

# Enforce Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.secure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enforce KMS Server-Side Encryption (SSE-KMS)
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_key.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# Block all Public Access (Zero-Trust Standard)
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enforce HTTPS-Only TLS Policy
resource "aws_s3_bucket_policy" "enforce_https" {
  bucket = aws_s3_bucket.secure_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceTLSRequestsOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.secure_bucket.arn,
          "${aws_s3_bucket.secure_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
