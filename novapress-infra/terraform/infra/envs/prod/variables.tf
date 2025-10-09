variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "network_name" {
  type = string
}

variable "boot_disk_image" {
  type = string
}

variable "env" {
  type = string
  validation {
    condition     = contains(["dev", "preprod", "prod"], var.env)
    error_message = "env must be one of : dev, preprod, prod"
  }
}

variable "mtu" {
  type = number
}

variable "routing_mode" {
  type = string
}

variable "subnet_public_name" {
  type = string
}

variable "subnet_ci_name" {
  type = string
}

variable "subnet_k8s_name" {
  type = string
}

variable "subnet_public_ip_range" {
  type = string
}

variable "subnet_ci_ip_range" {
  type = string
}

variable "subnet_k8s_ip_range" {
  type = string
}

variable "machine_type" {
  type = map(string)
}

variable "ssh_pubkey_path" {
  type = string
}
