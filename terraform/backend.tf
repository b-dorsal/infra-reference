terraform {
  backend "gcs" {
    bucket  = "bdor528-infra-reference-${terraform.workspace}"
    prefix  = "terraform/state/${terraform.workspace}"
  }
}