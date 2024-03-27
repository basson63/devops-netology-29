resource "yandex_vpc_network" "vpc-network" {
  folder_id   = var.folder_id
  name        = "network"
  description = "vpc-network"
}

resource "yandex_vpc_route_table" "nat-route-table" {
  network_id = yandex_vpc_network.vpc-network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.instance-nat-ip
  }
}

# Subnets of the network.
resource "yandex_vpc_subnet" "vpc-public" {
  folder_id      = var.folder_id
  name           = "public-subnet"
  description    = "public-subnet"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = var.yandex_cloud_zone
  network_id     = yandex_vpc_network.vpc-network.id
}

resource "yandex_vpc_subnet" "vpc-private" {
  folder_id      = var.folder_id
  name           = "private-subnet"
  description    = "private-subnet"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = var.yandex_cloud_zone
  network_id     = yandex_vpc_network.vpc-network.id
  route_table_id = yandex_vpc_route_table.nat-route-table.id
}