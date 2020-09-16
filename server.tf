variable "servers" {
  type = list
  default = ["srvr01", "srvr02", "srvr03", ]
}

variable "ips" {
  type = list
  default = ["10.30.1.11","10.30.1.12","10.30.1.13"]
}
resource "google_compute_instance" "spokevms" {
  
  count      = length(var.servers)
  name = var.servers[count.index]
  machine_type = "e2-small"
  zone    = "australia-southeast1-a"
  tags      = ["ssh", "http-tag"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-focal-v20200907"
    }
  }

  

  network_interface {
    #network = "google_compute_subnetwork.vm-provisioner-subnet.name"
    subnetwork = google_compute_subnetwork.k8s-nodes-subnet.name
    network_ip = var.ips[count.index]
    #access_config  {
      // Ephemeral IP
    #}
  }

  metadata = {
      #ssh-keys = "ubuntu:${file("./id_rsa.pub")}" # to use your key pair
      enable-oslogin = true
  }

  #metadata_startup_script = "ipconfig > .\sample.txt"

  service_account {
    scopes = []
  }
}


