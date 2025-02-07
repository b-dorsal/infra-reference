locals {
    config = yamldecode(file("${path.module}/../config/config.infra.yaml"))
    project_id = local.config.projects[terraform.workspace].project-id
    default_region = "us-central1"
    env_type = local.config.projects[terraform.workspace].type
}

resource "google_project_service" "required_services" {
  for_each = toset(local.config.apis)
  project = local.project_id
  service = each.key
}
