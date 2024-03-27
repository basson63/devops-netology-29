resource "yandex_vpc_network" "network" {
  name = "network"
}

#### приватная сеть для БД

resource "yandex_vpc_subnet" "private1" {
  name           = "private1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "private2" {
  name           = "private2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "private3" {
  name           = "private3"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}

#### Публичная сеть для сластера k8s

resource "yandex_vpc_subnet" "public1" {
  name           = "public1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.10.0.0/16"]
}

resource "yandex_vpc_subnet" "public2" {
  name           = "public2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.20.0.0/16"]
}

resource "yandex_vpc_subnet" "public3" {
  name           = "public3"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.30.0.0/16"]
}