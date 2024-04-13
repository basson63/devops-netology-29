#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu-2204-lts" {
  image_id = "fd8hnnsnfn3v88bk0k1o"
}

#создаем master node
resource "yandex_compute_instance" "master-node" {
  name        = "master-node"
  hostname    = "master-node."
  platform_id = "standard-v1"
  zone           = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.image_id
      type = "network-hdd"
      size = 50
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    user-data = "${data.template_file.cloudinit.rendered}"
  }

  scheduling_policy { preemptible = false }

  network_interface {
      subnet_id  = yandex_vpc_subnet.subnet-2.id
      nat = true
    }
}

#создаем nodes

resource "yandex_compute_instance" "worker-nodes" {
  count   = 2
  name        = "worker-node-${count.index}"
  hostname    = "worker-node-${count.index}."
  platform_id = "standard-v1"
  zone           = "ru-central1-b"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.image_id
      type = "network-hdd"
      size = 50
    }
  }

  metadata = {
    user-data = "${data.template_file.cloudinit.rendered}"
  }

  scheduling_policy { preemptible = false }

  network_interface {
      subnet_id  = "${yandex_vpc_subnet.subnet-zones[count.index].id}"
      nat = true
    }
}

#создаем jenkins
resource "yandex_compute_instance" "jenkins" {
  name        = "jenkins"
  hostname    = "jenkins."
  platform_id = "standard-v1"
  zone           = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.image_id
      type = "network-hdd"
      size = 50
    }
  }

  metadata = {
      user-data          = data.template_file.cloudinit.rendered
  }

  scheduling_policy { preemptible = false }

  network_interface {
      subnet_id  = yandex_vpc_subnet.subnet-2.id
      nat = true
    }
}

data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
}