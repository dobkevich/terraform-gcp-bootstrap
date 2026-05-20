variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region for the bucket"
  type        = string
  default     = "europe-north2"
}

variable "bucket_name_suffix" {
  description = "Suffix for the bucket name. Full name will be {project_id}-tfstate-{suffix}"
  type        = string
  default     = "bootstrap"
}
