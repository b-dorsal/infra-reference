resource "google_compute_network" "vpc_network" {
  name                    = "infra-reference-${local.env_type}"
  auto_create_subnetworks = false

  depends_on = [ google_project_service.required_services ]
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "gke-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = local.default_region
  network       = google_compute_network.vpc_network.id
}