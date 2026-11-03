output "gcs_bucket_name" {
  value       = google_storage_bucket.gcs_bucket.name
  description = "Name of the Google Cloud Storage bucket."
}

output "service_account_email" {
  value       = google_service_account.workload_sa.email
  description = "Email of the GCP Service Account."
}

