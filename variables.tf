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

variable "environment_for_outputs" {
  description = "Environment name to be used in outputs (in configuration samples)"
  type        = string
  default     = "prod"
}

variable "enable_github_wif" {
  description = "Whether to enable Workload Identity Federation"
  type        = bool
  default     = false
}

variable "github_owners" {
  description = "List of allowed GitHub owners (usernames or organizations)"
  type        = list(string)
  default     = ["owner"]
}

variable "github_repositories" {
  description = "List of GitHub repositories in 'owner/repo' format"
  type        = list(string)
  default     = ["owner/repo"]
}

variable "state_bucket_suffix" {
  description = "States bucket name suffix (full name will be {project_id}-{suffix})"
  type        = string
  default     = "terraform-states"

  validation {
    condition     = can(regex("^[a-z0-9_-]+$", var.state_bucket_suffix))
    error_message = "The state_bucket_suffix must contain only lowercase letters, numbers, hyphens, or underscores. Dots are not allowed."
  }
}
