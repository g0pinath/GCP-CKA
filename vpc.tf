provider "google" {
  credentials = file("./svc-core-infra-dev-deploy.json")
  project = "dev-core-infra"
  region  = "australia-southeast1"
  zone    = "australia-southeast1-a"
}


resource "google_compute_subnetwork" "vm-hub-provisioner-subnet" {
  name          = "vm-hub-provisioner-subnet"
  ip_cidr_range = "10.25.0.0/28"
  region  = "australia-southeast1"
  network       = google_compute_network.dev-hub-vpc-k8s.id  
}
#spoke subnets
resource "google_compute_subnetwork" "k8s-nodes-subnet" {
  name          = "k8s-nodes-subnet"
  ip_cidr_range = "10.30.1.0/24"
  region  = "australia-southeast1"
  network       = google_compute_network.dev-spoke-vpc-k8s.id  
}


resource "google_compute_subnetwork" "vm-spoke-provisioner-subnet" {
  name          = "vm-spoke-provisioner-subnet"
  ip_cidr_range = "10.30.2.0/28"
  region  = "australia-southeast1"
  network       = google_compute_network.dev-spoke-vpc-k8s.id  
}

resource "google_compute_network" "dev-hub-vpc-k8s" {
  name                    = "dev-hub-vpc-k8s"
  auto_create_subnetworks = false
}

resource "google_compute_network" "dev-spoke-vpc-k8s" {
  name                    = "dev-spoke-vpc-k8s"
  auto_create_subnetworks = false
}
