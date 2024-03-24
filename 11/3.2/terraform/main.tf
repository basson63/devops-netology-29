resource "yandex_vpc_network" "vpc-network" {
  folder_id   = var.folder_id
  name        = "k8s-network"
  description = "k8s network"
}

# Subnets of the network.
resource "yandex_vpc_subnet" "vpc-subnet" {
  folder_id      = var.folder_id
  name           = "k8s-subnet-0"
  description    = "k8s subnet 0"
  v4_cidr_blocks = ["10.200.0.0/24"]
  zone           = var.yandex_cloud_zone
  network_id     = yandex_vpc_network.vpc-network.id
}

resource "yandex_compute_instance" "instance" {
  count       = var.instance_count
  folder_id   = var.folder_id
  name        = "${var.instance_name}-${format(var.count_format, var.count_offset + count.index + 1)}"
  description = var.instance_description
  platform_id = var.instance_type
  hostname    = "${var.instance_name}-${format(var.count_format, var.count_offset + count.index + 1)}"
  zone        = var.yandex_cloud_zone

  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
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
