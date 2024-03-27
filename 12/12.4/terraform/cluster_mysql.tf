resource "yandex_mdb_mysql_cluster" "my-mysql-3" {
  name                = "my-mysql-3"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.network.id
  version             = "8.0"
  security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]
  deletion_protection = true

  maintenance_window {
    type = "ANYTIME"
  }

  backup_window_start {
    hours   = "23"
    minutes = "59"
  }

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-hdd"
    disk_size          = 20
  }

  host {
    zone             = "ru-central1-a"
    subnet_id        = yandex_vpc_subnet.private1.id
  }

  host {
    zone             = "ru-central1-b"
    subnet_id        = yandex_vpc_subnet.private2.id
    backup_priority  = 10
  }

  host {
    zone             = "ru-central1-c"
    subnet_id        = yandex_vpc_subnet.private3.id
  }
}

resource "yandex_mdb_mysql_database" "db1" {
  cluster_id = yandex_mdb_mysql_cluster.my-mysql-3.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "user1" {
  cluster_id = yandex_mdb_mysql_cluster.my-mysql-3.id
  name       = "user1"
  password   = "user1user1"
  permission {
    database_name = yandex_mdb_mysql_database.db1.name
    roles         = ["ALL"]
  }
}

resource "yandex_vpc_security_group" "mysql-sg" {
  name       = "mysql-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    description    = "MySQL"
    port           = 3306
    protocol       = "TCP"
    v4_cidr_blocks = [ "0.0.0.0/0" ]
  }
}

# Output data
output "connection_current_master" {
  description = "Master address in the database cluster"
  value       = "c-${yandex_mdb_mysql_cluster.my-mysql-3.id}.rw.mdb.yandexcloud.net"
}
output "connection_nodes" {
  description = "Addresses of created nodes in the database cluster"
  value       = yandex_mdb_mysql_cluster.my-mysql-3.host.*.fqdn
}
