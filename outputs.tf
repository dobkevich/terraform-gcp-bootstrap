output "_01_instructions" {
  value = <<-EOT

    STEPS TO BOOTSTRAP A NEW GCP PROJECT

    STAGE 1: INITIAL RUN (USING LOCAL STATE)
       Create a terraform.tfvars file and define values as explained in the README.
       Use "enable_github_wif = false" to skip GitHub setup (can be enabled later).
       Run 'terraform init' and 'terraform apply'.
       This will use local state, create the IAM roles and WIF, and prepare the
       GCS Bucket for remote Terraform state storage.

    STAGE 2: MIGRATE TO REMOTE STATE
       After the first apply, uncomment the 'backend "gcs"' block in 'terraform.tf'.
       Fill in the 'bucket' name with: ${module.state_bucket.bucket_name}
       Run 'terraform init -migrate-state' to migrate the local state to the cloud.

    STAGE 3: CONFIGURE REMOTE STATE STORAGE FOR OTHER PROJECTS
       Use the same remote state backend code and the bucket name for all Terraform
       projects used to manage infrastructure within a new GCP project, but change
       the "prefix" value like this:
       prefix = "terraform/terraform-project-name/state"
    EOT
}

output "_02_instructions" {
  description = "Commands to configure GitHub Actions variables using GitHub CLI (gh)"
  value = var.enable_github_wif ? format(
    "\nSTAGE 4: GITHUB ACTIONS SETUP\n   At this point, the GCP project is ready to be configured with Terraform\n   via CI/CD pipelines using GitHub Actions.\n   Copy the provided cicd_github_action.yaml into .github/workflows/ in your\n   Terraform repositories and run GitHub CLI (gh) commands in the target\n   repositories (or define these variables directly at github.com):\n\n   gh variable set GCP_PROJECT_ID --body \"%s\"\n   gh variable set GCP_WIF_PROVIDER --body \"%s\"\n   gh variable set GCP_WIF_SERVICE_ACCOUNT --body \"%s\"\n",
    var.project_id,
    module.iam_wif.workload_identity_provider,
    module.iam_wif.admin_service_account_email
  ) : ""
}

output "_03_instructions" {
  value = <<-EOT

    IAM AND USER SETUP DETAILS
    
    1. Human Admin (${var.admin_email}) has 'Editor', 'Project IAM Admin' and 'Billing Project Manager' roles.

    2. Standard User (${var.standard_user_email}) has the 'Viewer' role.

    3. Service Account '${module.iam_wif.admin_service_account_email}'
       has 'Editor' and 'Project IAM Admin' roles.

    4. To use a Service Account, use impersonation instead of JSON keys (they are less secure and may be disabled).

    5. To use the Service Account via CLI (after terraform apply):
       gcloud config set auth/impersonate_service_account ${module.iam_wif.admin_service_account_email}

       After this, all your 'gcloud' and 'terraform' commands will run
       as if you were that Service Account, with its permissions.

       Check:
       gcloud config list
       curl -H "Authorization: Bearer $(gcloud auth print-access-token)" https://www.googleapis.com/oauth2/v3/userinfo

       To leave impersonation mode:
       gcloud config unset auth/impersonate_service_account
    EOT
}
