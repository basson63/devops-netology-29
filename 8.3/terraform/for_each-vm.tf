data "yandex_compute_image" "centos-db" {
  family = var.vm_db_image
}

resource "yandex_compute_instance" "vm-each" {
   for_each = toset(keys({for idx, val in var.vm_resources: idx=> val}))
    name = var.vm_resources[each.value]["name"]
    platform_id = "standard-v1"

  resources {
    cores         = var.vm_resources[each.value]["cpu"]
    memory        = var.vm_resources[each.value]["ram"]
    core_fraction = var.vm_resources[each.value]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos-db.image_id
      type = var.vm_resources[each.value]["type"]
      size = var.vm_resources[each.value]["size"]
     }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
   }

  metadata = local.ssh_keys_and_serial_port
}

variable "vm_resources" {
  description = "resources vm(ram,cpu,disk,..)"
  type = list(object(
    {
      name          = string
      cpu           = number
      core_fraction = number
      ram           = number
#type disk      
      type          = string
#size disk
      size          = number
  }))
  default = [
    { 
      name          = "sonar"
      cpu           = 2
      ram           = 4
      disk          = 1
      core_fraction = 5
      type          = "network-hdd"
      size          = 10
    },
    {
      name          = "nexus"
      cpu           = 2
      ram           = 4
      disk          = 2
      core_fraction = 5
      type          = "network-hdd"
      size          = 10
    }
]
}
