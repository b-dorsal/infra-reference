resource "google_artifact_registry_repository" "my-repo" {
  for_each      = local.services
  location      = local.default_region
  repository_id = each.key
  description   = "${each.key} Docker repo"
  format        = "DOCKER"
}
