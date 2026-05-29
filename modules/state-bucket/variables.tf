variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region for the bucket"
  type        = string
  default     = "europe-north2"
}

variable "state_bucket_suffix" {
  description = "States bucket name suffix (full name will be {project_id}-{suffix})"
  type        = string
  default     = "terraform-states"
}
