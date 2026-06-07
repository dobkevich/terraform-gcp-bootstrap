variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "project_number" {
  description = "The GCP Project Number"
  type        = string
}

variable "admin_email" {
  description = "Email of the human administrator"
  type        = string
}

variable "standard_user_email" {
  description = "Email of a standard viewer user"
  type        = string
}

variable "github_owners" {
  description = "List of allowed GitHub owners (usernames or organizations)"
  type        = list(string)
  default     = ["owner"]
}

variable "github_repositories" {
  description = "List of GitHub repositories in 'owner/repo' format allowed to impersonate the SA"
  type        = list(string)
  default     = ["owner/repo"]
}

variable "enable_wif" {
  description = "Whether to enable Workload Identity Federation for GitHub"
  type        = bool
  default     = false
}
