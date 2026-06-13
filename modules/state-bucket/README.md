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
| [google_storage_bucket.tf_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| project\_id | The GCP Project ID | `string` | n/a | yes |
| region | GCP Region for the bucket | `string` | `"europe-north2"` | no |
| state\_bucket\_suffix | States bucket name suffix (full name will be {project\_id}-{suffix}) | `string` | `"terraform-states"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| bucket\_name | The name of the bucket for Terraform states |
| bucket\_url | The URL of the bucket for Terraform states |

<!-- END_TF_DOCS -->