resource "random_string" "gcp_suffix" {
  length  = 6
  special = false
  upper   = false
}

# Hardened Google Cloud Storage Bucket
resource "google_storage_bucket" "gcs_bucket" {
  name                        = "gcs-multicloud-${var.environment}-${random_string.gcp_suffix.result}"
  location                    = var.gcp_region
  uniform_bucket_level_access = true
  labels                      = var.labels

  versioning {
    enabled = true
  }
}

# Dedicated Service Account
resource "google_service_account" "workload_sa" {
  account_id   = "sa-multicloud-${var.environment}"
  display_name = "Multi-Cloud Workload Automation SA"
}

# Least-Privilege IAM Binding on GCS Bucket
resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_storage_bucket.gcs_bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.workload_sa.email}"
}

