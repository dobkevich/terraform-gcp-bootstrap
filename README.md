# GCP Project Bootstrap

A production-ready Terraform "Seed" project that automates initialization of a newly created Google Cloud Project and establishes the foundation needed to manage GCP infrastructure via CI/CD pipelines for Terraform using GitHub Actions with secure Workload Identity Federation (WIF) and multi-repo setup.

It configures base IAM/WIF and creates a bucket for remote Terraform state storage.

A typical pipeline for 'terraform plan' and 'terraform apply' may look like this:
```text
Terraform code -> GitHub -> GitHub Actions CI/CD -> WIF -> GCP

pull request -> terraform plan
merge -> terraform apply
```

## Key Features

- **Zero-Key Security**: Uses OIDC-based Workload Identity Federation (WIF) and Service Account Impersonation (no static JSON keys required).
- **Multi-Repo Ready**: Grant multiple GitHub repositories secure access to your GCP resources.
- **Automated API Enablement**: Automatically activates essential GCP services (IAM, Resource Manager, STS, etc.) with built-in propagation delay.
- **Robust State Management**: Provisions a GCS bucket with versioning and uniform access for reliable Terraform remote state storage.
- **Modular Architecture**: Cleanly separated logic for IAM/WIF and Storage, ready for reuse.

## Project Structure

```text
├── modules/
│   ├── iam-wif/             # IAM roles, Automation SA, and GitHub OIDC Federation
│   └── state-bucket/        # Versioned GCS bucket for Terraform state
├── main.tf                  # Root orchestrator with API enablement logic
├── variables.tf             # Global input variables
├── terraform.tf             # Provider configuration and Backend template
├── outputs.tf               # Deployment instructions and WIF details
└── cicd_github_action.yaml  # Sample GitHub Action for your future projects
```

## Prerequisites

1.  **GCP Project**: An existing Google Cloud Project ID.
2.  **Terraform**: Version 1.0 or higher.
3.  **Authentication**: Locally authenticated via `gcloud auth application-default login`.

## Deployment Workflow

### 1. Configuration
Create a `terraform.tfvars` file (this file is ignored by git):

```hcl
project_id          = "your-google-cloud-project-id"
region              = "europe-north2"
zone                = "europe-north2-b"
admin_email         = "your-email@example.com"
standard_user_email = "team-member@example.com"
enable_github_wif   = true
github_repositories = [
  "owner/your-infra-repo",
  "owner/your-app-repo"
]
```

If you do not plan to enable WIF for any GitHub repositories just set "enable_github_wif = false"
and "github_repositories" will be ignored.

### 2. Initial Bootstrap (Local State)
The first run will create the foundational resources and store the state file locally.

```bash
terraform init
terraform apply
```

### 3. Migrate State to GCS
Once the bucket is created, move your state file to the cloud:

1.  Note the `tf_state_bucket` name from the Terraform output.
2.  Open `terraform.tf` and uncomment the `backend "gcs"` block.
3.  Replace `REPLACE_WITH_BUCKET_NAME_FROM_OUTPUT` with your actual bucket name.
4.  Run the migration command:
    ```bash
    terraform init -migrate-state
    ```
5.  Type `yes` when prompted.

### 4. Configure GitHub Actions
In your GitHub repository, use the value from the `workload_identity_provider` output in your workflow files. Refer to `cicd_github_action.yaml` for the exact configuration.

## Security Compliance

- **Principle of Least Privilege**: While the automation SA starts with `Editor` for bootstrapping, it is scoped to prevent wide-scale organizational changes.
- **OIDC Mapping**: Implements `attribute_condition` and mapping for `repository_owner` to prevent identity spoofing.
- **State Protection**: GCS bucket uses `force_destroy = false` to prevent accidental deletion of infrastructure history.

## License

MIT
