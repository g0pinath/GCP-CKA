provider "google" {
  credentials = file("./svc-core-infra-dev-deploy.json")
  project = "dev-core-infra"
  region  = "australia-southeast1"
  zone    = "australia-southeast1-a"
}

#spoke subnets
resource "google_compute_subnetwork" "k8s-nodes-subnet" {
  name          = "k8s-nodes-subnet"
  ip_cidr_range = "10.30.1.0/24"
  region  = "australia-southeast1"
  network       = google_compute_network.dev-spoke-vpc-k8s.id  
}

#VPCs

resource "google_compute_network" "dev-hub-vpc-k8s" {
  name                    = "dev-hub-vpc-k8s"
  auto_create_subnetworks = false
}

resource "google_compute_network" "dev-spoke-vpc-k8s" {
  name                    = "dev-spoke-vpc-k8s"
  auto_create_subnetworks = false
}
#NAT Router for VMs without public IP to goto internet.

resource "google_compute_router" "router" {
  name    = "nat-router-australia-southeast1"
  network = google_compute_network.dev-spoke-vpc-k8s.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat-gateway-australia-southeast1"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}