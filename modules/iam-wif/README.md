<!-- BEGIN_TF_DOCS -->


## Requirements

No requirements.

## Providers

The following providers are used by this module:

- google

## Modules

No modules.

## Resources

The following resources are used by this module:

- [google_iam_workload_identity_pool.cicd_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) (resource)
- [google_iam_workload_identity_pool_provider.github_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) (resource)
- [google_project_iam_member.billing_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) (resource)
- [google_project_iam_member.human_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) (resource)
- [google_project_iam_member.human_iam_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) (resource)
- [google_project_iam_member.sa_editor_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) (resource)
- [google_project_iam_member.sa_iam_admin_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) (resource)
- [google_project_iam_member.standard_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) (resource)
- [google_service_account.project_admin_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) (resource)
- [google_service_account_iam_member.admin_impersonates_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) (resource)
- [google_service_account_iam_member.cicd_impersonation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) (resource)

## Required Inputs

The following input variables are required:

### admin\_email

Description: Email of the human administrator

Type: `string`

### project\_id

Description: The GCP Project ID

Type: `string`

### project\_number

Description: The GCP Project Number

Type: `string`

### standard\_user\_email

Description: Email of a standard viewer user

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### enable\_wif

Description: Whether to enable Workload Identity Federation for GitHub

Type: `bool`

Default: `false`

### github\_owners

Description: List of allowed GitHub owners (usernames or organizations)

Type: `list(string)`

Default:

```json
[
  "owner"
]
```

### github\_repositories

Description: List of GitHub repositories in 'owner/repo' format allowed to impersonate the SA

Type: `list(string)`

Default:

```json
[
  "owner/repo"
]
```

## Outputs

The following outputs are exported:

### admin\_service\_account\_email

Description: n/a

### workload\_identity\_provider

Description: n/a

<!-- END_TF_DOCS -->