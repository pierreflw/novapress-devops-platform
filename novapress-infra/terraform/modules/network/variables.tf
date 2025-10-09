variable "project_id" {
  type = string
}

variable "network_name" {
  type = string
}

variable "auto_create_subnets" {
  type    = bool
  default = false
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

variable "region" {
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

variable "env" {
  type = string
}