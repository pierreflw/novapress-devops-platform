terraform {
  backend "gcs" {
    bucket      = "tfstate_bucket_pfwpro_preprod"
    credentials = "../../../secrets/sa-key.json"
    prefix      = "tfstate/preprod"
  }
}