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
| [google_storage_bucket.tf_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP Region for the bucket | `string` | `"europe-north2"` | no |
| <a name="input_state_bucket_suffix"></a> [state\_bucket\_suffix](#input\_state\_bucket\_suffix) | States bucket name suffix (full name will be {project\_id}-{suffix}) | `string` | `"terraform-states"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the bucket for Terraform states |
| <a name="output_bucket_url"></a> [bucket\_url](#output\_bucket\_url) | The URL of the bucket for Terraform states |

<!-- END_TF_DOCS -->