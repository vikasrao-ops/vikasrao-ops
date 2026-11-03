variable "gcp_project_id" {
  type        = string
  description = "Target GCP Project ID."
  default     = "vikasrao-cloud-poc"
}

variable "gcp_region" {
  type        = string
  description = "Target GCP Region."
  default     = "us-central1"
}

variable "environment" {
  type        = string
  description = "Environment tier."
  default     = "poc"
}

variable "labels" {
  type = map(string)
  default = {
    platform   = "multicloud-automation"
    cloud      = "gcp"
    managed-by = "terraform"
  }
}
