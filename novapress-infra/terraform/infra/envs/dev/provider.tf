terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.39.0"
    }
  }
}

provider "google" {
  credentials = file("../../../secrets/sa-key.json")
  project     = var.project_id
  region      = var.region
}

