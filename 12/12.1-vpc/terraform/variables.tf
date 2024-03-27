# Instance settings.
variable folder_id { default = "" }
variable path_to_public_key { default = "~/.ssh/id_ed25519.pub" }
variable yandex_cloud_zone { default = "ru-central1-a" }
variable users { default = "ubuntu" }

variable instance_count { default = 1 }
variable instance_name { default = "instance" }
variable instance_description { default = "test" }
variable instance_type { default = "standard-v1" }
variable image_id { default = "fd8fo5t7f6j6iqvjnk3b" } 
variable domain { default = "mylocal" }

# VM settings.
variable cores { default = 2 }
variable core_fraction { default = 20 }
variable memory { default = 2 }
variable instance-nat-ip { default = "192.168.10.254" }
variable boot_disk { default = "network-hdd" }
variable disk_size {
  default = 10
  validation {
    condition = var.disk_size >= 10
    error_message = "Disk size must be not less than 10Gb!"
  }
}

# Service variables.
#start numbering from X+1 (e.g. name-1 if '0', name-3 if '2', etc.)
variable count_offset { default = 0 }
#server number format (-1, -2, etc.)
variable count_format { default = "%01d" }
