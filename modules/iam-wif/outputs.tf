output "admin_service_account_email" {
  value = google_service_account.project_admin_sa.email
}

output "workload_identity_provider" {
  value = var.enable_wif ? google_iam_workload_identity_pool_provider.github_provider[0].name : null
}
