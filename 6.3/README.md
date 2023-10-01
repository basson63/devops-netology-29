# Домашнее задание к занятию «Управляющие конструкции в коде Terraform»  

### Задание 1

1. Изучите проект.
2. Заполните файл personal.auto.tfvars
3. Инициализируйте проект, выполните код (он выполнится даже если доступа к preview нет).

<img
  src="https://github.com/basson63/devops-netology-29/blob/terraform-03/6.3/images/1.png"
  alt="image 1.png"
  title="image 1.png"
  style="display: inline-block; margin: 0 auto; width: 600px">


------

### Задание 2

1. Создайте файл count-vm.tf. Опишите в нём создание двух одинаковых ВМ web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент count loop. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )
```bash
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "dev" {
count = 2
name = "netology-develop-platform-dev-${count.index}"
platform_id = "standard-v1"
  resources {
    cores         = 2
    memory        = 4
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = "${var.ssh-keys_and_serial-port-enable}"
}
```

2. Создайте файл for_each-vm.tf. Опишите в нем создание 2 **разных** по cpu/ram/disk виртуальных машин, используя мета-аргумент **for_each loop**. Используйте переменную типа list(object({ vm_name=string, cpu=number, ram=number, disk=number  })). При желании внесите в переменную все возможные параметры.

```bash
variable "vms" {
  type = list(object(
    {
      name               = string
      cores              = number
      memory             = number
      size               = number
      core_fraction      = number
  }))
  default = [
     {
      name             = "netology-develop-platform-web1"
      cores            = 2
      memory           = 4
      size             = 5
      core_fraction    = 20
    },
    {
      name             = "netology-develop-platform-web2"

      cores            = 4
      memory           = 8
      size             = 10
      core_fraction    = 5
    }    
  ]
}

data "yandex_compute_image" "ubuntu_web" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "web" {
  for_each = toset(keys({for i, r in var.vms:  i => r}))
  platform_id = "standard-v1"
  name = var.vms[each.value]["name"]

  resources {
    cores = var.vms[each.value]["cores"]
    memory = var.vms[each.value]["memory"]
    core_fraction = var.vms[each.value]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vms[each.value]["size"]
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = "${var.ssh-keys_and_serial-port-enable}"
}
```

<img
  src=""https://github.com/basson63/devops-netology-29/blob/terraform-03/6.3/images/2.png"
  alt="image 2.png"
  title="image 2.png"
  style="display: inline-block; margin: 0 auto; width: 600px">


### Задание 3

1. Создайте 3 одинаковых виртуальных диска, размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count.

```bash
resource "yandex_compute_disk" "default" {
  count = 3
  name     = "disk-${count.index}"
  type     = "network-nvme"
  zone     = "ru-central1-a"
  size = 1
}
```

2. Создайте одну **любую** ВМ. Используйте блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных вами дополнительных дисков.

```bash
  dynamic secondary_disk {
    for_each = "${yandex_compute_disk.disk.*.id}"

    content {
      disk_id = yandex_compute_disk.disk["${secondary_disk.key}"].id
      auto_delete = true
    }
```

<img
src=""https://github.com/basson63/devops-netology-29/blob/terraform-03/6.3/images/3.png"
  alt="image 3.png"
  title="image 3.png"
  style="display: inline-block; margin: 0 auto; width: 600px">


3. Назначьте ВМ созданную в 1-м задании группу безопасности.

Сделано

```bash
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
```

------

### Задание 4

1. Создайте inventory-файл для ansible.
Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/demonstration2).
Передайте в него в качестве переменных имена и внешние ip-адреса ВМ из задания 2.1 и 2.2.

```bash
resource "local_file" "hosts_cfg" {
  depends_on = [resource.yandex_compute_instance.dev, resource.yandex_compute_instance.web, resource.yandex_compute_instance.test ]
  content = templatefile("${path.module}/hosts.tftpl",

    { webservers =  yandex_compute_instance.web,
      dev = yandex_compute_instance.dev,
      test = [yandex_compute_instance.test]
    }

  )
  filename = "${abspath(path.module)}/hosts.cfg"
}
```
<img
src=""https://github.com/basson63/devops-netology-29/blob/terraform-03/6.3/images/4.png"
  alt="image 4.png"
  title="image 4.png"
  style="display: inline-block; margin: 0 auto; width: 600px">

