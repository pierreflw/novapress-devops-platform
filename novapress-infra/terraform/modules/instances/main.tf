resource "google_compute_instance" "instance" {
  name         = "${var.env}-${var.role}-${var.suffix}"
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.disk_size
      labels = {
        env  = var.env
        role = var.role
      }
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet


    dynamic "access_config" {
      for_each = var.assign_public_ip ? [1] : []
      content {}
    }
  }

  metadata = {
    ssh-keys = "ansible:${var.ssh_public_key}"
  }

  labels = {
    role = var.role
  }
}