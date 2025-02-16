locals {
  config          = yamldecode(file("${path.module}/../../config/config.infra.yaml"))
  services_config = yamldecode(file("${path.module}/../../config/config.services.yaml"))
  services        = local.services_config.services
  project_id      = local.config.projects["infra-reference-${terraform.workspace}"].project-id
  default_region  = "us-central1"
  env_type        = local.config.projects["infra-reference-${terraform.workspace}"].type
}

resource "google_project_service" "required_services" {
  for_each = toset(local.config.apis)
  project  = local.project_id
  service  = each.key
}
