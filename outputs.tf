output "project_id" {
  value = var.project_id
}

output "tf_state_bucket" {
  value = module.state_bucket.bucket_name
}

output "workload_identity_provider" {
  value = module.iam_wif.workload_identity_provider
}

output "admin_service_account_email" {
  description = "The email of the created admin service account"
  value = module.iam_wif.admin_service_account_email
}

output "instructions" {
  value = <<-EOT
    1. Human Admin (${var.admin_email}) has 'Editor', 'Project IAM Admin' and 'Billing Project Manager' roles.
    2. Standard User (${var.standard_user_email}) has 'Viewer' role.
    3. Service Account '${module.iam_wif.admin_service_account_email}'
       has 'Editor' and 'Project IAM Admin' roles.
    4. To use a Service Account, use impersonation instead of JSON Keys (they are less secure and may be disabled).
    5. To use the Service Account via CLI (after terraform apply):
       gcloud config set auth/impersonate_service_account ${module.iam_wif.admin_service_account_email}

       After this, all your 'gcloud' and 'terraform' commands will run
       as if you were that Service Account, with its permissions.

       Check:
       gcloud config list
       curl -H "Authorization: Bearer $(gcloud auth print-access-token)" https://www.googleapis.com/oauth2/v3/userinfo

       Leave impersonation mode:
       gcloud config unset auth/impersonate_service_account

    WORKFLOW:

    1. INITIAL BOOTSTRAP:
       Run 'terraform init' and 'terraform apply'. 
       This will create the IAM roles, WIF, and the GCS Bucket.

    2. MIGRATE TO REMOTE STATE:
       After the first apply, uncomment the 'backend "gcs"' block in 'terraform.tf'.
       Fill in the 'bucket' name with: ${module.state_bucket.bucket_name}
       Run 'terraform init' again to migrate the state.

    3. GITHUB ACTIONS:
       Use the following Workload Identity Provider in your CI/CD:
       ${module.iam_wif.workload_identity_provider != null ? module.iam_wif.workload_identity_provider : "Not enabled"}
    EOT
}
