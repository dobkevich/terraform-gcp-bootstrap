# What it does:
#
# 1. Human Admin roles
# 2. Service Account for programmatic access and its roles
# 3. Allow Human Admin to IMPERSONATE this Service Account
# 4. Project-level Billing Management
# 5. Standard User Access


# 1. Human Admin roles
# Note: Using roles/editor instead of roles/owner for external users 
# to comply with GCP Organization policies (ORG_MUST_INVITE_EXTERNAL_OWNERS).
resource "google_project_iam_member" "human_admin_roles" {
  for_each = toset([
    "roles/editor",
    "roles/resourcemanager.projectIamAdmin", # IAM management
    "roles/servicenetworking.networksAdmin"  # required for Private Service Access
  ])
  project = var.project_id
  role    = each.key
  member  = "user:${var.admin_email}"
}


# 2. Service Account for programmatic access and its roles
resource "google_service_account" "project_admin_sa" {
  project      = var.project_id
  account_id   = "project-admin-sa"
  display_name = "Project Administrator Service Account"
  description  = "SA with Editor and IAM Admin permissions for automation/CLI"
}

resource "google_project_iam_member" "sa_roles" {
  for_each = toset([
    "roles/editor",
    "roles/resourcemanager.projectIamAdmin", # IAM management
    "roles/servicenetworking.networksAdmin"  # required for Private Service Access
  ])
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.project_admin_sa.email}"
}


# 3. Allow Human Admin to IMPERSONATE this Service Account
resource "google_service_account_iam_member" "admin_impersonates_sa" {
  service_account_id = google_service_account.project_admin_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "user:${var.admin_email}"
}


# 4. Project-level Billing Management
# Note: Full billing administration usually happens at the Billing Account level.
# roles/billing.projectManager allows managing billing for this specific project.
resource "google_project_iam_member" "billing_manager" {
  project = var.project_id
  role    = "roles/billing.projectManager"
  member  = "user:${var.admin_email}"
}


# 5. Standard User Access
# GCP users manage their own credentials via Google Account settings.
resource "google_project_iam_member" "standard_viewer" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "user:${var.standard_user_email}"
}
