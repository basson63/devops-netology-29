# Virtual machines
## Kubernetes master
resource "yandex_compute_instance" "vm-master" {
  name = "vm-master"
  hostname = "vm-master"
  zone      = "ru-central1-a"
  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = "fd80bm0rh4rkepi5ksdi"
      size = "10"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

## Kubernetes worker-1
resource "yandex_compute_instance" "vm-worker-1" {
  name = "vm-worker-1"
  hostname = "vm-worker-1"
  zone      = "ru-central1-a"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd80bm0rh4rkepi5ksdi"
      size = "10"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

## Kubernetes worker-2
resource "yandex_compute_instance" "vm-worker-2" {
  name = "vm-worker-2"
  hostname = "vm-worker-2"
  zone      = "ru-central1-b"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd80bm0rh4rkepi5ksdi"
      size = "10"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


