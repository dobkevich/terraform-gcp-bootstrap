<!-- BEGIN_TF_DOCS -->


## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| google | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_iam_workload_identity_pool.cicd_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.github_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_iam_member.billing_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.human_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.human_iam_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.sa_editor_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.sa_iam_admin_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.sa_service_networking_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.standard_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.project_admin_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.admin_impersonates_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.cicd_impersonation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| admin\_email | Email of the human administrator | `string` | n/a | yes |
| enable\_wif | Whether to enable Workload Identity Federation for GitHub | `bool` | `false` | no |
| github\_owners | List of allowed GitHub owners (usernames or organizations) | `list(string)` | <pre>[<br/>  "owner"<br/>]</pre> | no |
| github\_repositories | List of GitHub repositories in 'owner/repo' format allowed to impersonate the SA | `list(string)` | <pre>[<br/>  "owner/repo"<br/>]</pre> | no |
| project\_id | The GCP Project ID | `string` | n/a | yes |
| project\_number | The GCP Project Number | `string` | n/a | yes |
| standard\_user\_email | Email of a standard viewer user | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| admin\_service\_account\_email | n/a |
| workload\_identity\_provider | n/a |

<!-- END_TF_DOCS -->