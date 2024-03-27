resource "yandex_compute_instance" "instance_nat-vm" {
  count       = var.instance_count
  folder_id   = var.folder_id
  platform_id = var.instance_type
  name        = "${var.instance_name}-nat"
  hostname    = "${var.instance_name}-nat.${var.domain}"
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id = "fd836fv86ftfupovv972"
      type     = var.boot_disk
      size     = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc-public.id
    security_group_ids = [yandex_vpc_security_group.group1.id]
    nat       = true
    ip_address = var.instance-nat-ip
  }

    metadata = {
    ssh-keys = "${var.users}:${file(var.path_to_public_key)}"
  }
    scheduling_policy {
    preemptible = true
  }

  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "public-vm" {
  count       = var.instance_count
  folder_id   = var.folder_id
  platform_id = var.instance_type
  name        = "${var.instance_name}-public"
  hostname    = "${var.instance_name}-public.${var.domain}"
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
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc-public.id
    security_group_ids = [yandex_vpc_security_group.group1.id]
    nat       = true
  }
  
    metadata = {
    ssh-keys = "${var.users}:${file(var.path_to_public_key)}"
  }
    scheduling_policy {
    preemptible = true
  }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "private-vm" {
  count       = var.instance_count
  folder_id   = var.folder_id
  platform_id = var.instance_type
  name        = "${var.instance_name}-private"
  hostname    = "${var.instance_name}-private.${var.domain}"
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
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc-private.id
    security_group_ids = [yandex_vpc_security_group.group1.id]
  }
  
    metadata = {
    ssh-keys = "${var.users}:${file(var.path_to_public_key)}"
  }
    scheduling_policy {
    preemptible = true
  }
  allow_stopping_for_update = true
}