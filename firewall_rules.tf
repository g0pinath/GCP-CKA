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
  source_ranges = ["123.208.86.179/32", "0.0.0.0/0"]
  source_tags = ["ssh"]
}

#outbound to internet for apt update
resource "google_compute_firewall" "dev_allow_outbound_internet_spoke" {
  name    = "dev-allow-outbound-internet-spoke"
  network = google_compute_network.dev-spoke-vpc-k8s.name

  #allow {
    #protocol = "ssh"
  #}
  direction = "EGRESS"
  allow {
    protocol = "tcp"
    ports    = ["443", "80"]
  }
  destination_ranges = ["0.0.0.0/0"]
  
}