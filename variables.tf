variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region for resources"
  type        = string
  default     = "europe-north2"
}

variable "zone" {
  description = "GCP Zone for resources"
  type        = string
  default     = "europe-north2-b"
}

variable "admin_email" {
  description = "Email of the human administrator"
  type        = string
}

variable "standard_user_email" {
  description = "Email of a standard viewer user"
  type        = string
}

variable "enable_github_wif" {
  description = "Whether to enable Workload Identity Federation"
  type        = bool
  default     = false
}

variable "github_repositories" {
  description = "List of GitHub repositories in 'owner/repo' format"
  type        = list(string)
  default     = ["owner/repo"]
}

variable "state_bucket_suffix" {
  description = "Suffix for the TF state bucket"
  type        = string
  default     = "bootstrap"
}
