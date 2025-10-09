variable "suffix" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "zone" {
  type = string
}

variable "boot_disk_image" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "network" {
  type = string
}

variable "subnet" {
  type = string
}

variable "env" {
  type = string
}

variable "role" {
  type = string
}

variable "assign_public_ip" {
  type = bool
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "ssh_public_key" {
  type = string
}