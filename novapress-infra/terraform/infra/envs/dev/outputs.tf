output "ansible_inventory" {
  value = templatefile(local.ansible_inventory_template_path, {
    nginx_public_ip         = module.instance["nginx"].instance_public_ip
    nginx_private_ip        = module.instance["nginx"].instance_private_ip
    gitlab_private_ip       = module.instance["gitlab"].instance_private_ip
    monitoring_private_ip   = module.instance["monitoring"].instance_private_ip
    k3s_master_1_private_ip = module.instance["k3s_master_1"].instance_private_ip
    k3s_master_2_private_ip = module.instance["k3s_master_2"].instance_private_ip
    k3s_master_3_private_ip = module.instance["k3s_master_3"].instance_private_ip
    k3s_node_1_private_ip   = module.instance["k3s_node_1"].instance_private_ip
    k3s_node_2_private_ip   = module.instance["k3s_node_2"].instance_private_ip
    k3s_node_3_private_ip   = module.instance["k3s_node_3"].instance_private_ip
  })
}



