variable "gcp_project_id" {
  type        = string
  description = "Target GCP project ID."
  default     = "vikasrao-cloud-lab"
}

variable "gcp_region" {
  type        = string
  description = "Target GCP region."
  default     = "us-central1"
}

variable "environment" {
  type        = string
  description = "Environment tier."
  default     = "poc"
}

variable "labels" {
  type        = map(string)
  default = {
    environment = "poc"
    managed-by  = "terraform"
    project     = "gcp-foundation-poc"
  }
}

