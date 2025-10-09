locals {
  network                         = module.networks.vpc_network_self_link
  ansible_inventory_template_path = "${path.module}/templates/ansible-inventory-${var.env}.tmpl"
  ssh_key_content                 = file(var.ssh_pubkey_path)

  instances = {
    gitlab = {
      subnet           = module.networks.subnet_ci_self_link
      disk_size        = 40
      role             = "gitlab"
      suffix           = "01"
      tags             = ["ssh", "icmp", "http", "node-exporter", "gitlab-registry"]
      assign_public_ip = false
    }
    nginx = {
      subnet           = module.networks.subnet_public_self_link
      disk_size        = 10
      role             = "nginx-reverse-proxy"
      suffix           = "01"
      tags             = ["ssh", "icmp", "http", "https", "node-exporter", "reverse-proxy"]
      assign_public_ip = true
    }
    monitoring = {
      subnet           = module.networks.subnet_ci_self_link
      disk_size        = 10
      role             = "monitoring"
      suffix           = "01"
      tags             = ["ssh", "icmp", "node-exporter", "monitoring"]
      assign_public_ip = false
    }
    k3s_master_1 = {
      subnet           = module.networks.subnet_k8s_self_link
      disk_size        = 25
      role             = "master"
      suffix           = "01"
      tags             = ["ssh", "icmp", "k3s", "k8s-node", "node-exporter"]
      assign_public_ip = false
    }
    k3s_master_2 = {
      subnet           = module.networks.subnet_k8s_self_link
      disk_size        = 25
      role             = "master"
      suffix           = "02"
      tags             = ["ssh", "icmp", "k3s", "k8s-node", "node-exporter"]
      assign_public_ip = false
    }
    k3s_master_3 = {
      subnet           = module.networks.subnet_k8s_self_link
      disk_size        = 25
      role             = "master"
      suffix           = "03"
      tags             = ["ssh", "icmp", "k3s", "k8s-node", "node-exporter"]
      assign_public_ip = false
    }
    k3s_node_1 = {
      subnet           = module.networks.subnet_k8s_self_link
      disk_size        = 30
      role             = "node"
      suffix           = "01"
      tags             = ["ssh", "icmp", "k3s", "k8s-node", "node-exporter"]
      assign_public_ip = false
    }
    k3s_node_2 = {
      subnet           = module.networks.subnet_k8s_self_link
      disk_size        = 30
      role             = "node"
      suffix           = "02"
      tags             = ["ssh", "icmp", "k3s", "k8s-node", "node-exporter"]
      assign_public_ip = false
    }
    k3s_node_3 = {
      subnet           = module.networks.subnet_k8s_self_link
      disk_size        = 30
      role             = "node"
      suffix           = "03"
      tags             = ["ssh", "icmp", "k3s", "k8s-node", "node-exporter"]
      assign_public_ip = false
    }
  }
}