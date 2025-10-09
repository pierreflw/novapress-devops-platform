resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnets
  mtu                     = var.mtu
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "subnet_public" {
  name          = var.subnet_public_name
  ip_cidr_range = var.subnet_public_ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "subnet_ci" {
  name          = var.subnet_ci_name
  ip_cidr_range = var.subnet_ci_ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "subnet_k8s" {
  name          = var.subnet_k8s_name
  ip_cidr_range = var.subnet_k8s_ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_router" "router" {
  name    = "${var.network_name}-router"
  region  = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.network_name}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "allow_ssh_from_personal_ip" {
  name          = "allow-ssh-from-my-ip-${var.env}"
  network       = google_compute_network.vpc_network.id
  source_ranges = ["93.28.120.83/32"]
  target_tags   = ["ssh"]
  priority      = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_ssh_bastion" {
  name        = "allow-ssh-${var.env}"
  network     = google_compute_network.vpc_network.id
  source_tags = ["reverse-proxy"]
  target_tags = ["ssh"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_ssh_cicd" {
  name          = "allow-ssh-cicd-${var.env}"
  network       = google_compute_network.vpc_network.id
  source_ranges = ["10.0.2.0/24"]
  target_tags   = ["ssh"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}



resource "google_compute_firewall" "allow_http" {
  name          = "allow-http-${var.env}"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "allow_https" {
  name          = "allow-https-${var.env}"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

resource "google_compute_firewall" "allow_gitlab_registry" {
  name        = "allow-gitlab-registry-${var.env}"
  network     = google_compute_network.vpc_network.name
  source_tags = ["reverse-proxy"]
  target_tags = ["gitlab-registry"]

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }
}

resource "google_compute_firewall" "allow_icmp" {
  name          = "allow-icmp-${var.env}"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["icmp"]

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_node_exporter" {
  name        = "allow-node-exporter-${var.env}"
  network     = google_compute_network.vpc_network.name
  source_tags = ["monitoring"]
  target_tags = ["node-exporter"]

  allow {
    protocol = "tcp"
    ports    = ["9100"]
  }
}

resource "google_compute_firewall" "allow_k3s_api" {
  name          = "allow-k3s-api-${var.env}"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["10.0.3.0/24"]
  target_tags   = ["k3s"]

  allow {
    protocol = "tcp"
    ports    = ["6443"]
  }
}

resource "google_compute_firewall" "allow_k3s_supervisor" {
  name          = "allow-k3s-supervisor-${var.env}"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["10.0.3.0/24"]
  target_tags   = ["k3s"]

  allow {
    protocol = "tcp"
    ports    = ["9345"]
  }
}

resource "google_compute_firewall" "allow_flannel_vxlan" {
  name          = "allow-vxlan-${var.env}"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["10.0.3.0/24"]
  target_tags   = ["k8s-node"]

  allow {
    protocol = "udp"
    ports    = ["8472"]
  }
}

resource "google_compute_firewall" "allow_kubelet_webhook" {
  name          = "allow-kubelet-webhook-${var.env}"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["10.0.3.0/24"]
  target_tags   = ["k8s-node"]

  allow {
    protocol = "tcp"
    ports    = ["10250"]
  }
}

resource "google_compute_firewall" "allow_etcd_internal" {
  name          = "allow-etcd-internal-${var.env}"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["10.0.3.0/24"]
  target_tags   = ["k3s"]

  allow {
    protocol = "tcp"
    ports = [
      "2379",
      "2380"
    ]
  }
}

resource "google_compute_firewall" "allow_traefik_nodeports" {
  name        = "allow-traefik-nodeports-${var.env}"
  network     = google_compute_network.vpc_network.name
  source_tags = ["reverse-proxy"]
  target_tags = ["k8s-node"]

  allow {
    protocol = "tcp"
    ports = [
      "31080",
      "31443"
    ]
  }
}