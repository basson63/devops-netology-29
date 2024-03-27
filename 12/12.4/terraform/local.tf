resource "local_file" "k8s-config" {
  content = <<-DOC
  yc managed-kubernetes cluster get-credentials --id ${yandex_kubernetes_cluster.k8s-regional.id} --external
  sleep 2
  kubectl apply -f myphp.yaml
  sleep 2
  kubectl get svc -o wide

    DOC
  filename = "./finish.sh"

  depends_on = [
    yandex_kubernetes_node_group.k8s-node,
    local_file.deployment
  ]
}

resource "null_resource" "cluster" {
  provisioner "local-exec" {
    command = "./finish.sh"
  }
  depends_on = [
    local_file.k8s-config
  ]
}