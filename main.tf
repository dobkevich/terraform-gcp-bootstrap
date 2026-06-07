data "google_project" "current" {
  project_id = var.project_id
  depends_on = [google_project_service.required_apis]
}

# Enable required APIs for the project
resource "google_project_service" "required_apis" {
  for_each = toset([
    "serviceusage.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sts.googleapis.com",
    "iamcredentials.googleapis.com",
    "storage.googleapis.com"
  ])

  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

# Wait for APIs to propagate
resource "time_sleep" "wait_for_apis" {
  depends_on      = [google_project_service.required_apis]
  create_duration = "30s"
}

module "iam_wif" {
  source = "./modules/iam-wif"

  project_id          = var.project_id
  project_number      = data.google_project.current.number
  admin_email         = var.admin_email
  standard_user_email = var.standard_user_email
  enable_wif          = var.enable_github_wif
  github_owners       = var.github_owners
  github_repositories = var.github_repositories

  depends_on = [time_sleep.wait_for_apis]
}

module "state_bucket" {
  source = "./modules/state-bucket"

  project_id          = var.project_id
  region              = var.region
  state_bucket_suffix = var.state_bucket_suffix

  depends_on = [time_sleep.wait_for_apis]
}
