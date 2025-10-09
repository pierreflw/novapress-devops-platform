terraform {
  backend "gcs" {
    bucket      = "tfstate_bucket_pfwpro_dev"
    credentials = "../../../secrets/sa-key.json"
    prefix      = "tfstate/dev"
  }
}