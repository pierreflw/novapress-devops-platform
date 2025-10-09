terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.39.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Service Account Terraform
resource "google_service_account" "terraform" {
  account_id   = var.account_id
  display_name = var.display_name
}

# Permissions projet
resource "google_project_iam_member" "terraform_sa_storage_admin" {
  member  = "serviceAccount:${google_service_account.terraform.email}"
  project = var.project_id
  role    = "roles/storage.admin"
}

resource "google_project_iam_member" "terraform_sa_compute_admin" {
  member  = "serviceAccount:${google_service_account.terraform.email}"
  project = var.project_id
  role    = "roles/compute.admin"
}

# Buckets pour les tfstates
resource "google_storage_bucket" "dev-tfstate_bucket" {
  location = var.region
  name     = var.dev_bucket_name
  versioning {
    enabled = true
  }
  uniform_bucket_level_access = true
  force_destroy               = true
}

resource "google_storage_bucket" "preprod-tfstate_bucket" {
  location = var.region
  name     = var.preprod_bucket_name
  versioning {
    enabled = true
  }
  uniform_bucket_level_access = true
  force_destroy               = true
}

resource "google_storage_bucket" "prod-tfstate_bucket" {
  location = var.region
  name     = var.prod_bucket_name
  versioning {
    enabled = true
  }
  uniform_bucket_level_access = true
  force_destroy               = true
}

# Droits sur les buckets
resource "google_storage_bucket_iam_member" "tf_state_bucket_admin_dev" {
  bucket = google_storage_bucket.dev-tfstate_bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_storage_bucket_iam_member" "tf_state_bucket_admin_preprod" {
  bucket = google_storage_bucket.preprod-tfstate_bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_storage_bucket_iam_member" "tf_state_bucket_admin_prod" {
  bucket = google_storage_bucket.prod-tfstate_bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.terraform.email}"
}
