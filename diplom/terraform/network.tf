# Creating a cloud network

resource "yandex_vpc_network" "network" {
  name = "my-net"
}

# Creating subnets

resource "yandex_vpc_subnet" "subnet-zones" {
  count          = 2
  name           = "subnet-${count.index}"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.network.id}"
  v4_cidr_blocks = [ "${var.cidr.blocks[count.index]}" ]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet-2"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}
