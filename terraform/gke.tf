resource "google_container_cluster" "primary" {
  name     = "infra-reference-${local.env_type}"
  location = local.default_region

  enable_autopilot = true
  initial_node_count       = 1
  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.vpc_subnetwork.id
}