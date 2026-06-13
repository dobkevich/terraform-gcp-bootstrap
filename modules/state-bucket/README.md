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

- [google_storage_bucket.tf_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) (resource)

## Required Inputs

The following input variables are required:

### project\_id

Description: The GCP Project ID

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### region

Description: GCP Region for the bucket

Type: `string`

Default: `"europe-north2"`

### state\_bucket\_suffix

Description: States bucket name suffix (full name will be {project\_id}-{suffix})

Type: `string`

Default: `"terraform-states"`

## Outputs

The following outputs are exported:

### bucket\_name

Description: The name of the bucket for Terraform states

### bucket\_url

Description: The URL of the bucket for Terraform states

<!-- END_TF_DOCS -->