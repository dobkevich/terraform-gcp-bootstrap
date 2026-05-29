output "bucket_name" {
  value       = google_storage_bucket.tf_state.name
  description = "The name of the bucket for Terraform states"
}

output "bucket_url" {
  value       = google_storage_bucket.tf_state.url
  description = "The URL of the bucket for Terraform states"
}
