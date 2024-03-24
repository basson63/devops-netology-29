
resource "yandex_compute_instance" "haproxy" {
  count       = var.instance_ha
  folder_id   = var.folder_id
  name        = "${var.instance_name_ha}-${format(var.count_format, var.count_offset + count.index + 1)}"
  description = var.instance_description
  platform_id = var.instance_type
  hostname    = "${var.instance_name_ha}-${format(var.count_format, var.count_offset + count.index + 1)}"
  zone        = var.yandex_cloud_zone

  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id = var.image_ha
      type     = var.boot_disk
      size     = var.disk_size
    }
  }
  # Прерываемая VM
  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.vpc-subnet.id
    # Флаг nat указывает что будет публичный IP у VM
    nat = true
  }

  metadata = {
    ssh-keys = "${var.users}:${file(var.path_to_public_key)}"
  }

  allow_stopping_for_update = true
}
