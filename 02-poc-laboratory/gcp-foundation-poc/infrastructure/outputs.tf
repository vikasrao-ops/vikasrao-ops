output "bucket_name" {
  value       = google_storage_bucket.poc_bucket.name
  description = "Name of the created GCS bucket."
}

output "service_account_email" {
  value       = google_service_account.app_sa.email
  description = "Email of the provisioned service account."
}

