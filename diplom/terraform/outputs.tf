output "master_ip_address_nat" {
  value = yandex_compute_instance.master-node.network_interface.0.nat_ip_address
}

output "jenkins_ip_address_nat" {
  value = yandex_compute_instance.jenkins.network_interface.0.nat_ip_address
}

 output "worker_nodes_ip_address_nat" {
   value =  [ for name in yandex_compute_instance.worker-nodes : ["name  = ${name.name}", "ip_address_nat = ${name.network_interface.0.nat_ip_address}"]]
 }

output "master_ip_address" {
  value = yandex_compute_instance.master-node.network_interface.0.ip_address
}

output "jenkins_ip_address" {
  value = yandex_compute_instance.jenkins.network_interface.0.ip_address
}

 output "worker_nodes_ip_address" {
   value =  [ for name in yandex_compute_instance.worker-nodes : ["name  = ${name.name}", "ip_address = ${name.network_interface.0.ip_address}"]]
 }