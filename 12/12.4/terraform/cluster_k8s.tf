resource "yandex_kubernetes_cluster" "k8s-regional" {
  name       = "k8s-regional"
  network_id = yandex_vpc_network.network.id
  master {
    version   = "1.28"
    public_ip = true

    regional {
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.public1.zone
        subnet_id = yandex_vpc_subnet.public1.id
      }

      location {
        zone      = yandex_vpc_subnet.public2.zone
        subnet_id = yandex_vpc_subnet.public2.id
      }

      location {
        zone      = yandex_vpc_subnet.public3.zone
        subnet_id = yandex_vpc_subnet.public3.id
      }
    }

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "Wednesday"
        start_time = "23:59"
        duration   = "3h"
      }
    }
  }

  service_account_id      = yandex_iam_service_account.sadmin.id
  node_service_account_id = yandex_iam_service_account.sadmin.id
  depends_on = [
  yandex_resourcemanager_folder_iam_binding.editor,
  yandex_resourcemanager_folder_iam_binding.images-puller,
  yandex_resourcemanager_folder_iam_binding.k8s-clusters-agent,
  yandex_resourcemanager_folder_iam_binding.vpc-public-admin,
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}

# Output data
output "k8s_external_v4_endpoint" {
  value       = yandex_kubernetes_cluster.k8s-regional.master[0].external_v4_endpoint
  description = "Endpoint for connecting to a cluster"
}
output "k8s_cluster_id" {
  value       = yandex_kubernetes_cluster.k8s-regional.id
  description = "ID of created cluster"
}