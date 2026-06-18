# Set up Workload Identity Federation (WIF).
# WIF allows external CI/CD (like GitHub Actions) to impersonate a GCP 
# Service Account without the need for insecure, static JSON keys.

locals {
  pool_id = "cicd-pool"
}

# 1. Create a Workload Identity Pool (a container for external identities).
resource "google_iam_workload_identity_pool" "cicd_pool" {
  count                     = var.enable_wif ? 1 : 0
  project                   = var.project_id
  workload_identity_pool_id = local.pool_id
  display_name              = "CI/CD Identity Pool"
  description               = "Identity pool for GitHub Actions or other CI/CD providers"
}

# 2. Create an Identity Pool Provider for GitHub.
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  count                              = var.enable_wif ? 1 : 0
  project                            = var.project_id
  workload_identity_pool_id          = local.pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub Actions Provider"

  # Map GitHub JWT claims to GCP attributes
  # "assertion.repository" contains "owner/repo"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  # Security best practice: restrict at the provider level to specific owners
  attribute_condition = length(var.github_owners) > 0 ? format("assertion.repository_owner in [%s]", join(",", [for owner in var.github_owners : format("'%s'", owner)])) : "assertion.repository_owner != ''"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  depends_on = [google_iam_workload_identity_pool.cicd_pool]
}

# 3. Allow your GitHub repository to impersonate the Project Admin SA.
# This grants the workloadIdentityUser role to the specified GitHub repo(s).
resource "google_service_account_iam_member" "cicd_impersonation" {
  for_each           = var.enable_wif ? toset(var.github_repositories) : []
  service_account_id = google_service_account.project_admin_sa.name
  role               = "roles/iam.workloadIdentityUser"

  # Best practice: use project NUMBER in the principalSet
  member = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${local.pool_id}/attribute.repository/${each.value}"
}
