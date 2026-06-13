<!-- BEGIN_TF_DOCS -->


## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

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
| [google_project_iam_member.standard_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.project_admin_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.admin_impersonates_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.cicd_impersonation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_email"></a> [admin\_email](#input\_admin\_email) | Email of the human administrator | `string` | n/a | yes |
| <a name="input_enable_wif"></a> [enable\_wif](#input\_enable\_wif) | Whether to enable Workload Identity Federation for GitHub | `bool` | `false` | no |
| <a name="input_github_owners"></a> [github\_owners](#input\_github\_owners) | List of allowed GitHub owners (usernames or organizations) | `list(string)` | <pre>[<br/>  "owner"<br/>]</pre> | no |
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | List of GitHub repositories in 'owner/repo' format allowed to impersonate the SA | `list(string)` | <pre>[<br/>  "owner/repo"<br/>]</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP Project ID | `string` | n/a | yes |
| <a name="input_project_number"></a> [project\_number](#input\_project\_number) | The GCP Project Number | `string` | n/a | yes |
| <a name="input_standard_user_email"></a> [standard\_user\_email](#input\_standard\_user\_email) | Email of a standard viewer user | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_service_account_email"></a> [admin\_service\_account\_email](#output\_admin\_service\_account\_email) | n/a |
| <a name="output_workload_identity_provider"></a> [workload\_identity\_provider](#output\_workload\_identity\_provider) | n/a |

<!-- END_TF_DOCS -->