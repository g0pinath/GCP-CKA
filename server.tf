variable "servers" {
  type = list
  default = ["srvr01", "srvr02", "srvr03", ]
}

variable "ips" {
  type = list
  default = ["10.25.0.11","10.25.0.12","10.25.0.13"]
}
resource "google_compute_instance" "hubvms" {
  
  count      = length(var.servers)
  name = var.servers[count.index]
  machine_type = "n1-standard-1"
  zone    = "australia-southeast1-a"
  tags      = ["ssh"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-focal-v20200907"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    #network = "google_compute_subnetwork.vm-provisioner-subnet.name"
    subnetwork = google_compute_subnetwork.vm-hub-provisioner-subnet.name
    network_ip = var.ips[count.index]
    #access_config {
      // Ephemeral IP
    #}
  }

  metadata = {
      #ssh-keys = "ubuntu:${file("./id_rsa.pub")}" # to use your key pair
  }

  #metadata_startup_script = "ipconfig > .\sample.txt"

  service_account {
    scopes = []
  }
}


