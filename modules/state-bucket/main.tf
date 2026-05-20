resource "google_storage_bucket" "tf_state" {
  project  = var.project_id
  name     = "${var.project_id}-tfstate-${var.bucket_name_suffix}"
  location = var.region

  # Prevent accidental deletion of the state bucket
  force_destroy = false

  # Enable versioning to allow recovery of old states
  versioning {
    enabled = true
  }

  # Use uniform bucket-level access for better security management
  uniform_bucket_level_access = true

  # Optional: Lifecycle rule to clean up old versions after 90 days
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 5
      days_since_noncurrent_time = 90
    }
  }
}
