terraform {
  backend "gcs" {
    bucket  = "bdor528-infra-reference-dev"
    prefix  = "terraform/state/k8s"
  }
}