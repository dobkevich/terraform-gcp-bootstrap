terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.14"
    }
  }

  # AFTER the first 'terraform apply', uncomment this block and run
  # 'terraform init -migrate-state' to migrate local state to the cloud.

  # backend "gcs" {
  #   bucket = "REPLACE_WITH_BUCKET_NAME_FROM_OUTPUT"
  #   prefix = "bootstrap"
  # }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
