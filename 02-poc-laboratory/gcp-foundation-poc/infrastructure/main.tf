resource "random_string" "rand" {
  length  = 6
  special = false
  upper   = false
}

# 1. Google Cloud Storage Bucket with Uniform Access
resource "google_storage_bucket" "poc_bucket" {
  name                        = "gcs-foundation-${var.environment}-${random_string.rand.result}"
  location                    = var.gcp_region
  uniform_bucket_level_access = true
  labels                      = var.labels

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}

# 2. Service Account for Applications
resource "google_service_account" "app_sa" {
  account_id   = "sa-gcp-foundation-${var.environment}"
  display_name = "GCP Foundation POC App Service Account"
}

# 3. IAM Member Binding (Least-Privilege: Viewer Only)
resource "google_storage_bucket_iam_member" "viewer_binding" {
  bucket = google_storage_bucket.poc_bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.app_sa.email}"
}

