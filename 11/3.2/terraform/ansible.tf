resource "local_file" "prod_ini" {
  depends_on = [yandex_compute_instance.instance]
  content = templatefile("${path.module}/prod.tftpl",
    { wm = yandex_compute_instance.instance
    }
  )

  filename = "${abspath(path.module)}/../playbook/inventory/prod.ini"
}
