resource "yandex_compute_instance_group" "master" {
  name               = "masters"
  service_account_id = yandex_iam_service_account.ladmin.id
  depends_on = [
    yandex_iam_service_account.ladmin,
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_vpc_network.network,
    yandex_vpc_subnet.subnet-1,
  ]
  
  # Шаблон экземпляра, к которому принадлежит группа экземпляров.
  instance_template {

    # Имя виртуальных машин, создаваемых Instance Groups
    name = "master-{instance.index}"

    # Ресурсы, которые будут выделены для создания виртуальных машин в Instance Groups
    resources {
      cores  = 2
      memory = 2
      core_fraction = 20 # Базовый уровень производительности vCPU. https://cloud.yandex.ru/docs/compute/concepts/performance-levels
    }

    # Загрузочный диск в виртуальных машинах в Instance Groups
    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit" 
        size     = 4
        type     = "network-hdd"
      }
    }
    # Прерываемая вм
    scheduling_policy {
      preemptible = true
    }

    network_interface {
      network_id = yandex_vpc_network.network.id
      subnet_ids = [yandex_vpc_subnet.subnet-1.id]
      # Флаг nat true указывает что виртуалкам будет предоставлен публичный IP адрес.
      nat = true
    }

    metadata = {
      user-data = "${file("cloud-init.yaml")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 1
    max_expansion   = 1
    max_deleting    = 1
  }

  load_balancer {
    target_group_name = "masters"
  }
}