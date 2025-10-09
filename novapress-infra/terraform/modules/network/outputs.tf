output "vpc_network_self_link" {
  value = google_compute_network.vpc_network.self_link
}

output "subnet_public_self_link" {
  value = google_compute_subnetwork.subnet_public.self_link
}

output "subnet_ci_self_link" {
  value = google_compute_subnetwork.subnet_ci.self_link
}

output "subnet_k8s_self_link" {
  value = google_compute_subnetwork.subnet_k8s.self_link
}

output "vpc_network_name" {
  value = google_compute_network.vpc_network.name
}