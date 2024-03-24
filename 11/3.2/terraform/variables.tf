# Instance settings.
variable "folder_id" { default = "" }
variable "path_to_public_key" { default = "~/.ssh/id_rsa.pub" }
variable "yandex_cloud_zone" { default = "ru-central1-a" }
variable "users" { default = "vit" }

variable "instance_count" { default = 5 }
variable "instance_ha" { default = 1 }
variable "instance_name" { default = "my-kube" }
variable "instance_name_ha" { default = "ha-kube" }
variable "instance_description" { default = "k8s cluster" }
variable "instance_type" { default = "standard-v1" }
variable "image_id" { default = "fd8tir33idvbn40d00nm" } # ubuntu-20-04-lts-v20231120
variable "image_ha" { default = "fd8un8f40qgmlenpa0qb" } # ubuntu-22-04-lts-v20231120
# VM settings.
variable "cores" { default = 2 }
variable "core_fraction" { default = 20 }
variable "memory" { default = 2 }
variable "boot_disk" { default = "network-hdd" }
variable "disk_size" {
  default = 30
  validation {
    condition     = var.disk_size >= 30
    error_message = "Disk size must be not less than 30Gb!"
  }
}

# Service variables.
#start numbering from X+1 (e.g. name-1 if '0', name-3 if '2', etc.)
variable "count_offset" { default = 0 }
#server number format (-1, -2, etc.)
variable "count_format" { default = "%01d" }
