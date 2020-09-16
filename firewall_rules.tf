resource "google_compute_firewall" "dev_allow_ssh_hub" {
  name    = "dev-hub-allow-ssh"
  network = google_compute_network.dev-hub-vpc-k8s.name

  #allow {
    #protocol = "ssh"
  #}

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["123.208.86.179/32"]
  source_tags = ["ssh"]
}

resource "google_compute_firewall" "dev_allow_ssh_spoke" {
  name    = "dev-spoke-allow-ssh"
  network = google_compute_network.dev-spoke-vpc-k8s.name

  #allow {
    #protocol = "ssh"
  #}

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["123.208.86.179/32"]
  source_tags = ["ssh"]
}