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
├── boilerplate/                  # Ready-to-use files for your future projects
│   ├── cicd_github_actions.yaml  # GitHub Actions CI/CD workflow for Terraform
│   └── .tflint.hcl               # TFLint config with Google Cloud ruleset
├── modules/
│   ├── iam-wif/                  # IAM roles, Automation SA, and GitHub OIDC Federation
│   └── state-bucket/             # Versioned GCS bucket for Terraform state
├── main.tf                       # Root orchestrator with API enablement logic
├── variables.tf                  # Global input variables
├── terraform.tf                  # Provider and backend configuration
├── outputs.tf                    # Deployment instructions and WIF details
├── .gitignore                    # Standard Git ignore rules
└── LICENSE                       # MIT License
```

## Prerequisites

1.  **GCP Project**: An existing Google Cloud Project ID.
2.  **Terraform**: Version 1.0 or higher.
3.  **Authentication**: Locally authenticated via `gcloud auth application-default login`.

## Deployment Workflow

### 1. Configuration
Create a `terraform.tfvars` file (this file is ignored by git):

```hcl
project_id              = "GCP_PROJECT_ID"
region                  = "europe-north2"
zone                    = "europe-north2-b"
admin_email             = "your-email@example.com"
standard_user_email     = "team-member@example.com"
environment_for_outputs = "prod"
enable_github_wif       = true
github_owners           = ["some-org", "some-user"]
github_repositories     = [
  "some-org/infra-repo",
  "some-user/app-repo"
]
```

If you do not plan to enable WIF for any GitHub repositories just set "enable_github_wif = false"
and "github_owners" and "github_repositories" will be ignored.

The 'environment_for_outputs' variable is used only in outputs.tf for configuration samples
and does not affect any real infrastructure configuration. Default is "prod".
When we bootstrap a new GCP project it is supposed to be used as an environment, like
production, development, testing etc. This variable is used to provide relevant configuration
commands and should contain an environment name (e.g., prod, dev, test).

### 2. Initial Bootstrap (Local State)
The first run will create the foundational resources and store the state file locally.

```bash
terraform init
terraform apply
```

### 3. Migrate State to GCS
Once the bucket is created, move your state file to the cloud:

1.  Note the bucket name from the `_01_instructions` Terraform output.
2.  Open `terraform.tf` and uncomment the `backend "gcs"` block.
3.  Replace `REPLACE_WITH_BUCKET_NAME_FROM_OUTPUT` with your actual bucket name.
4.  Run the migration command:
    ```bash
    terraform init -migrate-state
    ```
5.  Type `yes` when prompted.

### 4. Configure your Terraform projects.

Follow the instructions in the output for configuring remote state storage and GitHub Actions workflow for your projects.

## Security Compliance

- **Principle of Least Privilege**: While the automation SA starts with `Editor` for bootstrapping, it is scoped to prevent wide-scale organizational changes.
- **OIDC Mapping**: Implements `attribute_condition` to restrict access by GitHub owners (organizations/users) and `attribute.repository` mapping for granular per-repo access control.
- **State Protection**: GCS bucket uses `force_destroy = false` to prevent accidental deletion of infrastructure history.

## License

MIT

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.14 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.0 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.14 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_iam_wif"></a> [iam\_wif](#module\_iam\_wif) | ./modules/iam-wif | n/a |
| <a name="module_state_bucket"></a> [state\_bucket](#module\_state\_bucket) | ./modules/state-bucket | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [google_project_service.required_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [time_sleep.wait_for_apis](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_email"></a> [admin\_email](#input\_admin\_email) | Email of the human administrator | `string` | n/a | yes |
| <a name="input_enable_github_wif"></a> [enable\_github\_wif](#input\_enable\_github\_wif) | Whether to enable Workload Identity Federation | `bool` | `false` | no |
| <a name="input_environment_for_outputs"></a> [environment\_for\_outputs](#input\_environment\_for\_outputs) | Environment name to be used in outputs (in configuration samples) | `string` | `"prod"` | no |
| <a name="input_github_owners"></a> [github\_owners](#input\_github\_owners) | List of allowed GitHub owners (usernames or organizations) | `list(string)` | <pre>[<br/>  "owner"<br/>]</pre> | no |
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | List of GitHub repositories in 'owner/repo' format | `list(string)` | <pre>[<br/>  "owner/repo"<br/>]</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP Region for resources | `string` | `"europe-north2"` | no |
| <a name="input_standard_user_email"></a> [standard\_user\_email](#input\_standard\_user\_email) | Email of a standard viewer user | `string` | n/a | yes |
| <a name="input_state_bucket_suffix"></a> [state\_bucket\_suffix](#input\_state\_bucket\_suffix) | States bucket name suffix (full name will be {project\_id}-{suffix}) | `string` | `"terraform-states"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP Zone for resources | `string` | `"europe-north2-b"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output__01_instructions"></a> [\_01\_instructions](#output\_\_01\_instructions) | Steps to initialize a new GCP project and configure remote state storage |
| <a name="output__02_instructions"></a> [\_02\_instructions](#output\_\_02\_instructions) | Commands to configure GitHub Actions variables using GitHub CLI (gh) |
| <a name="output__03_instructions"></a> [\_03\_instructions](#output\_\_03\_instructions) | IAM and user setup details |

<!-- END_TF_DOCS -->