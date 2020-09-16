variable "provservers" {
  type = list
  default = ["vm-prov01"]
}

variable "provips" {
  type = list
  default = ["10.30.1.10"]
}
resource "google_compute_instance" "prov_vms" {
  
  count      = length(var.provservers)
  name = var.provservers[count.index]
  machine_type = "n1-standard-1"
  zone    = "australia-southeast1-a"
  tags      = ["ssh"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-focal-v20200907"
    }
  }

  

  network_interface {
    #network = "google_compute_subnetwork.vm-provisioner-subnet.name"
    subnetwork = google_compute_subnetwork.k8s-nodes-subnet.name
    network_ip = var.provips[count.index]
    access_config  {
      // Ephemeral IP
    }
  }

  metadata = {
  #    ssh-keys = "ubuntu:${file("./id_rsa.pub")}" # to use your key pair but this wont work for connecting via internal IP or root@IP
      #Use https://cloud.google.com/compute/docs/instances/managing-instance-access this method instead.
      enable-oslogin = true
  }

  #metadata_startup_script = "ipconfig > .\sample.txt"

  service_account {
    scopes = []
  }
}


