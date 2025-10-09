module "networks" {
  source                 = "../../../modules/network"
  project_id             = var.project_id
  region                 = var.region
  network_name           = var.network_name
  env                    = var.env
  mtu                    = var.mtu
  routing_mode           = var.routing_mode
  subnet_ci_ip_range     = var.subnet_ci_ip_range
  subnet_ci_name         = var.subnet_ci_name
  subnet_k8s_ip_range    = var.subnet_k8s_ip_range
  subnet_k8s_name        = var.subnet_k8s_name
  subnet_public_ip_range = var.subnet_public_ip_range
  subnet_public_name     = var.subnet_public_name
  auto_create_subnets    = false
}

module "instance" {
  for_each         = local.instances
  source           = "../../../modules/instances"
  boot_disk_image  = var.boot_disk_image
  disk_size        = each.value.disk_size
  network          = local.network
  subnet           = each.value.subnet
  env              = var.env
  zone             = var.zone
  machine_type     = var.machine_type[each.key]
  role             = each.value.role
  suffix           = each.value.suffix
  tags             = each.value.tags
  assign_public_ip = each.value.assign_public_ip
  ssh_public_key   = local.ssh_key_content
}