output "_01_instructions" {
  description = "Steps to initialize a new GCP project and configure remote state storage"
  value = <<-EOT

    A NEW GCP PROJECT INITIALIZATION AND NEXT STEPS

    STAGE 1: INITIAL RUN (USING LOCAL STATE)
       Create a terraform.tfvars file and define values as explained in the README.
       Use "enable_github_wif = false" to skip GitHub setup (can be enabled later).
       Run 'terraform init' and 'terraform apply'.
       This will use local state, create the IAM roles and WIF, and prepare the
       GCS bucket for remote Terraform state storage.

    STAGE 2: MIGRATE TO REMOTE STATE
       After the first apply, uncomment the 'backend "gcs"' block in 'terraform.tf'.
       Fill in the 'bucket' name with: ${module.state_bucket.bucket_name}
       Run 'terraform init -migrate-state' to migrate the local state to the cloud.

    STAGE 3: CONFIGURE REMOTE STATE STORAGE FOR YOUR PROJECTS
       In 'terraform {...}' block use empty 'backend "gcs" {}' block and run the
       following sample commands in the root directory of a Terraform project to
       create the ${var.environment_for_outputs}.tfbackend file for an environment:

       mkdir -p environments
       echo 'bucket = "${module.state_bucket.bucket_name}"' > environments/${var.environment_for_outputs}.tfbackend
       echo 'prefix = "YOUR_TERRAFORM_PROJECT_NAME"' >> environments/${var.environment_for_outputs}.tfbackend
    EOT
}

output "_02_instructions" {
  description = "Commands to configure GitHub Actions variables using GitHub CLI (gh)"
  value = var.enable_github_wif ? format(
    "\nSTAGE 4: GITHUB ACTIONS SETUP\n   Copy files from boilerplate/ directory to your Terraform repositories:\n      cicd_github_actions.yaml to .github/workflows/\n      .tflint.hcl to the root directory\n   Run GitHub CLI (gh) commands inside every target repository directory\n   (or define these variables directly at github.com):\n\n   gh api -X PUT /repos/:owner/:repo/environments/%s\n   gh variable set GCP_PROJECT_ID --body \"%s\" --env %s\n   gh variable set GCP_WIF_PROVIDER --body \"%s\" --env %s\n   gh variable set GCP_WIF_SERVICE_ACCOUNT --body \"%s\" --env %s\n   gh variable list --env %s\n",
    var.environment_for_outputs,
    var.project_id, var.environment_for_outputs,
    module.iam_wif.workload_identity_provider, var.environment_for_outputs,
    module.iam_wif.admin_service_account_email, var.environment_for_outputs,
    var.environment_for_outputs
  ) : ""
}

output "_03_instructions" {
  description = "IAM and user setup details"
  value = <<-EOT

    IAM AND USER SETUP DETAILS
    
    1. Human Admin (${var.admin_email}) has the 'Editor', 'Project IAM Admin', and 'Billing Project Manager' roles.

    2. Standard User (${var.standard_user_email}) has the 'Viewer' role.

    3. Service Account '${module.iam_wif.admin_service_account_email}'
       has the 'Editor', 'Project IAM Admin', and 'Workload Identity User' roles.

    4. To use a service account, use impersonation instead of JSON keys (they are less secure and may be disabled).

    5. To use the service account via CLI (after terraform apply):
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
