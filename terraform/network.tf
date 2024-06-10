# VPC
resource "yandex_vpc_network" "network-diploma" {
  name = "network-diploma"
  folder_id = var.yc_folder_id
}

# Subnets
resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet-a"
  folder_id = var.yc_folder_id 
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-diploma.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-b" {
  name           = "subnet-b"
  folder_id = var.yc_folder_id
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-diploma.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "subnet-c" {
  name           = "subnet-c"
  folder_id = var.yc_folder_id
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network-diploma.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}
