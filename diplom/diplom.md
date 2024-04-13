# Дипломный практикум в Yandex.Cloud

## Этапы выполнения:

### 1. Создание облачной инфраструктуры

Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако. Состав инфраструктуры: 4 ВМ (jenkins, master node и 2 worker), сервисный аккаунт, backend, VPC с подсетями в разных зонах доступности (зону C не использовал, т.к. постоянно получал ошибку про квоту ресурсов в этой зоне). Команды `terraform destroy` и `terraform apply`  выполнятся без дополнительных ручных действий.

[terraform](https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/terraform)


```bash
  Enter a value: yes

yandex_iam_service_account.sergo-diplom: Creating...
yandex_kms_symmetric_key.key-a: Creating...
yandex_vpc_network.network: Creating...
yandex_kms_symmetric_key.key-a: Creation complete after 1s [id=abjsudgf0vnucbqqq7hp]
yandex_vpc_network.network: Creation complete after 2s [id=enprqggd2v1paql9u4av]
yandex_vpc_subnet.subnet-2: Creating...
yandex_vpc_subnet.subnet-zones[0]: Creating...
yandex_vpc_subnet.subnet-zones[1]: Creating...
yandex_vpc_subnet.subnet-zones[0]: Creation complete after 1s [id=e2laki7n2o25m09e7gmk]
yandex_iam_service_account.sergo-diplom: Creation complete after 3s [id=ajem9pfe02d88phcpia8]
yandex_resourcemanager_folder_iam_binding.editor: Creating...
yandex_resourcemanager_folder_iam_binding.encrypterDecrypter: Creating...
yandex_iam_service_account_static_access_key.bucket-static_access_key: Creating...
yandex_resourcemanager_folder_iam_binding.storage-admin: Creating...
yandex_vpc_subnet.subnet-zones[1]: Creation complete after 1s [id=e2lpt5etkg6epbe5pa69]
yandex_compute_instance.worker-nodes[0]: Creating...
yandex_compute_instance.worker-nodes[1]: Creating...
yandex_vpc_subnet.subnet-2: Creation complete after 2s [id=e9baoaavr842usqpp4l9]
yandex_compute_instance.jenkins: Creating...
yandex_compute_instance.master-node: Creating...
yandex_iam_service_account_static_access_key.bucket-static_access_key: Creation complete after 2s [id=aje0lnhkjcqv9hkls5eo]
yandex_storage_bucket.diplom-bucket: Creating...
yandex_resourcemanager_folder_iam_binding.editor: Creation complete after 3s [id=b1gjsnlha3fii86tav22/editor]
yandex_resourcemanager_folder_iam_binding.encrypterDecrypter: Creation complete after 5s [id=b1gjsnlha3fii86tav22/kms.keys.encrypterDecrypter]
yandex_storage_bucket.diplom-bucket: Creation complete after 5s [id=diplom-bucket]
local_file.backendConf: Creating...
local_file.backendConf: Creation complete after 0s [id=b451e10b3b429138bed44ac0de20387ac785b76d]
yandex_storage_object.object-1: Creating...
yandex_storage_object.object-1: Creation complete after 0s [id=terraform/terraform.tfstate]
yandex_resourcemanager_folder_iam_binding.storage-admin: Creation complete after 8s [id=b1gjsnlha3fii86tav22/storage.admin]
yandex_compute_instance.worker-nodes[1]: Still creating... [10s elapsed]
yandex_compute_instance.worker-nodes[0]: Still creating... [10s elapsed]
yandex_compute_instance.jenkins: Still creating... [10s elapsed]
yandex_compute_instance.master-node: Still creating... [10s elapsed]
yandex_compute_instance.worker-nodes[0]: Still creating... [20s elapsed]
yandex_compute_instance.worker-nodes[1]: Still creating... [20s elapsed]
yandex_compute_instance.master-node: Still creating... [20s elapsed]
yandex_compute_instance.jenkins: Still creating... [20s elapsed]
yandex_compute_instance.worker-nodes[1]: Still creating... [30s elapsed]
yandex_compute_instance.worker-nodes[0]: Still creating... [30s elapsed]
yandex_compute_instance.jenkins: Still creating... [30s elapsed]
yandex_compute_instance.master-node: Still creating... [30s elapsed]
yandex_compute_instance.master-node: Creation complete after 32s [id=fhm1kqra63sj68r2rgte]
yandex_compute_instance.jenkins: Creation complete after 35s [id=fhmokaokg1hophs0ah1k]
yandex_compute_instance.worker-nodes[1]: Still creating... [40s elapsed]
yandex_compute_instance.worker-nodes[0]: Still creating... [40s elapsed]
yandex_compute_instance.worker-nodes[1]: Creation complete after 41s [id=epdf69btc59e2ddb8cn5]
yandex_compute_instance.worker-nodes[0]: Creation complete after 43s [id=epdm73fldgskb4rcg322]

Apply complete! Resources: 17 added, 0 changed, 0 destroyed.

Outputs:

jenkins_ip_address = "192.168.1.20"
jenkins_ip_address_nat = "158.160.57.38"
master_ip_address = "192.168.1.33"
master_ip_address_nat = "158.160.36.239"
worker_nodes_ip_address = [
  [
    "name  = worker-node-0",
    "ip_address = 192.168.2.8",
  ],
  [
    "name  = worker-node-1",
    "ip_address = 192.168.3.26",
  ],
]
worker_nodes_ip_address_nat = [
  [
    "name  = worker-node-0",
    "ip_address_nat = 51.250.107.247",
  ],
  [
    "name  = worker-node-1",
    "ip_address_nat = 51.250.27.49",
  ],
]
sergo@ubuntu-pc:~/Work/diplom$ 
```

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/1.png"
  alt="image 1.png"
  title="image 1.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/2.png"
  alt="image 2.png"
  title="image 2.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/3.png"
  alt="image 3.png"
  title="image 3.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/4.png"
  alt="image 4.png"
  title="image 4.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/5.png"
  alt="image 5.png"
  title="image 5.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">



---

### 2. Создание Kubernetes кластера

Запустить и сконфигурировать Kubernetes кластер. Воспользовался [Kubespray](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/) 

[ansible](https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/ansible)

```bash
sergo@ubuntu-pc:~/Work/kubespray/inventory/mycluster$ cat hosts.yaml 
all:
  hosts:
    node1:
      ansible_host: 158.160.36.239
      ansible_user: ubuntu
      ip: 192.168.1.33
      access_ip: 192.168.1.33
    node2:
      ansible_host: 51.250.107.247
      ansible_user: ubuntu
      ip: 192.168.2.8
      access_ip: 192.168.2.8
    node3:
      ansible_host: 51.250.27.49
      ansible_user: ubuntu
      ip: 192.168.3.26
      access_ip: 192.168.3.26
  children:
    kube_control_plane:
      hosts:
        node1:
    kube_node:
      hosts:
        node1:
        node2:
        node3:
    etcd:
      hosts:
        node1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
sergo@ubuntu-pc:~/Work/kubespray/inventory/mycluster$ 
```

```bash
sergo@ubuntu-pc:~/Work/kubespray$ ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v
...
...
здесь был огромный вывод
...
...
PLAY RECAP *********************************************************************************************************************************************************************************************************************************************
node1                      : ok=718  changed=145  unreachable=0    failed=0    skipped=1180 rescued=0    ignored=6   
node2                      : ok=441  changed=87   unreachable=0    failed=0    skipped=690  rescued=0    ignored=1   
node3                      : ok=441  changed=87   unreachable=0    failed=0    skipped=690  rescued=0    ignored=1   

Воскресенье 03 марта 2024  06:28:17 +0000 (0:00:00.106)       0:11:38.325 ***** 
=============================================================================== 
download : Download_file | Download item ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 127.61s
container-engine/crictl : Download_file | Download item ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 20.44s
kubernetes/kubeadm : Join to cluster ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 20.24s
download : Download_file | Download item ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 14.45s
download : Download_container | Download image if required ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 14.23s
kubernetes-apps/ansible : Kubernetes Apps | Lay Down CoreDNS templates ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 13.82s
download : Download_container | Download image if required ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 13.42s
kubernetes/control-plane : Kubeadm | Initialize first master ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 11.28s
download : Download_container | Download image if required ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 10.24s
download : Download_file | Download item -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 8.93s
download : Download_container | Download image if required -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 8.63s
download : Download_container | Download image if required -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 8.49s
download : Download_container | Download image if required -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 8.43s
etcd : Reload etcd ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 7.49s
network_plugin/calico : Calico | Create calico manifests ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 7.45s
kubernetes/preinstall : Install packages requirements ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 6.60s
download : Download_container | Download image if required -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 6.47s
network_plugin/calico : Wait for calico kubeconfig to be created -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 6.43s
download : Download_container | Download image if required -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 6.39s
kubernetes-apps/ansible : Kubernetes Apps | Start Resources ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 6.22s
sergo@ubuntu-pc:~/Work/kubespray$ 
```

Перегенерировал сертификат, добавил внешний IP. Иначе получал ошибку, скорее всего это можно было сделать до установки k8s.

```bash
root@node1:~/.kube# rm /etc/kubernetes/pki/apiserver.* -f
root@node1:~/.kube# kubeadm init phase certs apiserver --apiserver-cert-extra-sans 10.233.0.1 --apiserver-cert-extra-sans 192.168.1.33 --apiserver-cert-extra-sans 158.160.36.239 --apiserver-cert-extra-sans localhost
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local localhost node1] and IPs [10.96.0.1 192.168.1.33 10.233.0.1 158.160.36.239]
root@node1:~/.kube#
```

Отредактировал kubectl config на своей ВМ:

```bash
sergo@ubuntu-pc:~/.kube$ cat config 
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ...
    server: https://158.160.36.239:6443
  name: cluster.local
contexts:
- context:
    cluster: cluster.local
    user: kubernetes-admin
  name: kubernetes-admin@cluster.local
current-context: kubernetes-admin@cluster.local
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: ...
    client-key-data: ...
sergo@ubuntu-pc:~/.kube$
```

Результат работы kubectl, отрабатывает без ошибок:

```bash
sergo@ubuntu-pc:~/Work/diplom$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
node1   Ready    control-plane   20m   v1.29.2
node2   Ready    <none>          20m   v1.29.2
node3   Ready    <none>          20m   v1.29.2
sergo@ubuntu-pc:~/Work/diplom$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-648dffd99-m9qww   1/1     Running   0          19m
kube-system   calico-node-cs5qf                         1/1     Running   0          19m
kube-system   calico-node-svzbf                         1/1     Running   0          19m
kube-system   calico-node-xxsjb                         1/1     Running   0          19m
kube-system   coredns-69db55dd76-7j4d9                  1/1     Running   0          19m
kube-system   coredns-69db55dd76-jxtm2                  1/1     Running   0          19m
kube-system   dns-autoscaler-6f4b597d8c-npzmc           1/1     Running   0          19m
kube-system   kube-apiserver-node1                      1/1     Running   1          21m
kube-system   kube-controller-manager-node1             1/1     Running   2          21m
kube-system   kube-proxy-7q9qh                          1/1     Running   0          20m
kube-system   kube-proxy-8js7f                          1/1     Running   0          20m
kube-system   kube-proxy-fmw47                          1/1     Running   0          20m
kube-system   kube-scheduler-node1                      1/1     Running   1          21m
kube-system   nginx-proxy-node2                         1/1     Running   0          20m
kube-system   nginx-proxy-node3                         1/1     Running   0          20m
kube-system   nodelocaldns-lbxvs                        1/1     Running   0          19m
kube-system   nodelocaldns-m2v2p                        1/1     Running   0          19m
kube-system   nodelocaldns-rkkpp                        1/1     Running   0          19m
sergo@ubuntu-pc:~/Work/diplom$ 
```
---

### 3. Создание тестового приложения

Создан отдельный git репозиторий с простым nginx конфигом.

[app](https://github.com/Serg2211/app.git)

[Dockerfile](https://github.com/Serg2211/app/blob/main/Dockerfile) для создания образа приложения.

```dockerfile
FROM nginx:latest
WORKDIR /usr/share/nginx/html
COPY . /usr/share/nginx/html/
```

Регистри с собранным docker image. В качестве регистри использован DockerHub.

[DockerHub](https://hub.docker.com/repository/docker/sergo2211/app/general)

---

### 4. Подготовка cистемы мониторинга и деплой приложения

Способ выполнения:
1. Воспользовался пакетом [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus).

```bash
ubuntu@node1:~$ sudo apt install golang
...
ubuntu@node1:~$ go version
go version go1.18.1 linux/amd64
ubuntu@node1:~$
```

Установил jsonnet-bundler:

```bash
ubuntu@node1:~/kube-prometheus$ go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest
go: downloading github.com/jsonnet-bundler/jsonnet-bundler v0.5.1
go: downloading github.com/fatih/color v1.13.0
go: downloading github.com/pkg/errors v0.9.1
go: downloading gopkg.in/alecthomas/kingpin.v2 v2.2.6
go: downloading github.com/mattn/go-isatty v0.0.14
go: downloading github.com/mattn/go-colorable v0.1.12
go: downloading github.com/alecthomas/units v0.0.0-20211218093645-b94a6e3cc137
go: downloading github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751
go: downloading golang.org/x/sys v0.0.0-20220615213510-4f61da869c0c
ubuntu@node1:~/kube-prometheus$
```

```bash
ubuntu@node1:~/kube-prometheus$ jb init
jb: command not found
ubuntu@node1:~/kube-prometheus$ export PATH=$PATH:$(go env GOPATH)/bin
ubuntu@node1:~/kube-prometheus$ export GOPATH=$(go env GOPATH)
ubuntu@node1:~/kube-prometheus$ jb init
ubuntu@node1:~/kube-prometheus$ jb install github.com/prometheus-operator/kube-prometheus/jsonnet/kube-prometheus@main
GET https://github.com/prometheus-operator/kube-prometheus/archive/a8ba97a150c75be42010c75d10b720c55e182f1a.tar.gz 200
GET https://github.com/prometheus-operator/prometheus-operator/archive/f433619e9a0e9be14e8830661f5f75c9b0cdd269.tar.gz 200
GET https://github.com/kubernetes/kube-state-metrics/archive/44c65d27238c2a2e58099ef56fdc40529561ca91.tar.gz 200
GET https://github.com/prometheus/prometheus/archive/d5f0a240faade2c694dfc877e3ac151b896bf66c.tar.gz 200
GET https://github.com/pyrra-dev/pyrra/archive/551856d42dff02ec38c5b0ea6a2d99c4cb127e82.tar.gz 200
GET https://github.com/thanos-io/thanos/archive/4c7997d25acc57166bfd726a64cc3c5710fcfe29.tar.gz 200
GET https://github.com/brancz/kubernetes-grafana/archive/5698c8940b6dadca3f42107b7839557bc041761f.tar.gz 200
GET https://github.com/grafana/grafana/archive/1120f9e255760a3c104b57871fcb91801e934382.tar.gz 200
GET https://github.com/etcd-io/etcd/archive/e68afe7eb7ce3e5f83deb2a8ad58faa3b35494b9.tar.gz 200
GET https://github.com/prometheus/node_exporter/archive/c371a7f582bf2b9a185fc51bd0d3e842937a8ab2.tar.gz 200
GET https://github.com/prometheus/alertmanager/archive/1eb83c21ebf4515386933298ee07e87f1c67f35e.tar.gz 200
GET https://github.com/prometheus-operator/prometheus-operator/archive/f433619e9a0e9be14e8830661f5f75c9b0cdd269.tar.gz 200
GET https://github.com/kubernetes-monitoring/kubernetes-mixin/archive/a1c276d7a46c4b06fa5d8b4a64441939d398efe5.tar.gz 200
GET https://github.com/kubernetes/kube-state-metrics/archive/44c65d27238c2a2e58099ef56fdc40529561ca91.tar.gz 200
GET https://github.com/grafana/grafonnet-lib/archive/a1d61cce1da59c71409b99b5c7568511fec661ea.tar.gz 200
GET https://github.com/grafana/jsonnet-libs/archive/8e9c60e6464c5030dd3b506bdb92c3dbab0394f7.tar.gz 200
GET https://github.com/grafana/grafonnet/archive/fe65a22df6d3a897729fff47cff599805a2c5710.tar.gz 200
GET https://github.com/jsonnet-libs/xtd/archive/295816ad067c7408053702174634189af802f915.tar.gz 200
GET https://github.com/jsonnet-libs/docsonnet/archive/6ac6c69685b8c29c54515448eaca583da2d88150.tar.gz 200
GET https://github.com/grafana/grafonnet-lib/archive/a1d61cce1da59c71409b99b5c7568511fec661ea.tar.gz 200
GET https://github.com/grafana/grafonnet/archive/fe65a22df6d3a897729fff47cff599805a2c5710.tar.gz 200
GET https://github.com/grafana/grafonnet/archive/fe65a22df6d3a897729fff47cff599805a2c5710.tar.gz 200
ubuntu@node1:~/kube-prometheus$ 
```

```bash
ubuntu@node1:~/kube-prometheus$ wget https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/example.jsonnet
--2024-03-03 07:12:05--  https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/example.jsonnet
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.108.133, 185.199.109.133, 185.199.110.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.108.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 2273 (2.2K) [text/plain]
Saving to: ‘example.jsonnet’

example.jsonnet                                               100%[=================================================================================================================================================>]   2.22K  --.-KB/s    in 0s      

2024-03-03 07:12:06 (41.2 MB/s) - ‘example.jsonnet’ saved [2273/2273]

ubuntu@node1:~/kube-prometheus$ wget https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/build.sh
--2024-03-03 07:12:22--  https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/build.sh
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.111.133, 185.199.109.133, 185.199.108.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.111.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 679 [text/plain]
Saving to: ‘build.sh’

build.sh                                                      100%[=================================================================================================================================================>]     679  --.-KB/s    in 0s      

2024-03-03 07:12:22 (30.9 MB/s) - ‘build.sh’ saved [679/679]

ubuntu@node1:~/kube-prometheus$ chmod 755 build.sh 
ubuntu@node1:~/kube-prometheus$ jb update
GET https://github.com/prometheus-operator/kube-prometheus/archive/a8ba97a150c75be42010c75d10b720c55e182f1a.tar.gz 200
GET https://github.com/brancz/kubernetes-grafana/archive/5698c8940b6dadca3f42107b7839557bc041761f.tar.gz 200
GET https://github.com/grafana/grafana/archive/1120f9e255760a3c104b57871fcb91801e934382.tar.gz 200
GET https://github.com/kubernetes-monitoring/kubernetes-mixin/archive/a1c276d7a46c4b06fa5d8b4a64441939d398efe5.tar.gz 200
GET https://github.com/kubernetes/kube-state-metrics/archive/44c65d27238c2a2e58099ef56fdc40529561ca91.tar.gz 200
GET https://github.com/prometheus/node_exporter/archive/c371a7f582bf2b9a185fc51bd0d3e842937a8ab2.tar.gz 200
GET https://github.com/prometheus/prometheus/archive/d5f0a240faade2c694dfc877e3ac151b896bf66c.tar.gz 200
GET https://github.com/pyrra-dev/pyrra/archive/551856d42dff02ec38c5b0ea6a2d99c4cb127e82.tar.gz 200
GET https://github.com/etcd-io/etcd/archive/e68afe7eb7ce3e5f83deb2a8ad58faa3b35494b9.tar.gz 200
GET https://github.com/prometheus-operator/prometheus-operator/archive/f433619e9a0e9be14e8830661f5f75c9b0cdd269.tar.gz 200
GET https://github.com/prometheus-operator/prometheus-operator/archive/f433619e9a0e9be14e8830661f5f75c9b0cdd269.tar.gz 200
GET https://github.com/kubernetes/kube-state-metrics/archive/44c65d27238c2a2e58099ef56fdc40529561ca91.tar.gz 200
GET https://github.com/prometheus/alertmanager/archive/1eb83c21ebf4515386933298ee07e87f1c67f35e.tar.gz 200
GET https://github.com/thanos-io/thanos/archive/4c7997d25acc57166bfd726a64cc3c5710fcfe29.tar.gz 200
GET https://github.com/grafana/grafonnet/archive/fe65a22df6d3a897729fff47cff599805a2c5710.tar.gz 200
GET https://github.com/grafana/jsonnet-libs/archive/8e9c60e6464c5030dd3b506bdb92c3dbab0394f7.tar.gz 200
GET https://github.com/grafana/grafonnet-lib/archive/a1d61cce1da59c71409b99b5c7568511fec661ea.tar.gz 200
GET https://github.com/grafana/grafonnet/archive/fe65a22df6d3a897729fff47cff599805a2c5710.tar.gz 200
GET https://github.com/jsonnet-libs/docsonnet/archive/6ac6c69685b8c29c54515448eaca583da2d88150.tar.gz 200
GET https://github.com/jsonnet-libs/xtd/archive/295816ad067c7408053702174634189af802f915.tar.gz 200
GET https://github.com/grafana/grafonnet-lib/archive/a1d61cce1da59c71409b99b5c7568511fec661ea.tar.gz 200
GET https://github.com/grafana/grafonnet/archive/fe65a22df6d3a897729fff47cff599805a2c5710.tar.gz 200
ubuntu@node1:~/kube-prometheus$ 
```

```bash
ubuntu@node1:~/kube-prometheus$ go install github.com/brancz/gojsontoyaml@latest
go: downloading github.com/brancz/gojsontoyaml v0.1.0
go: downloading github.com/ghodss/yaml v1.0.0
go: downloading gopkg.in/yaml.v2 v2.4.0
ubuntu@node1:~/kube-prometheus$ go install github.com/google/go-jsonnet/cmd/jsonnet@latest
go: downloading github.com/google/go-jsonnet v0.20.0
go: downloading github.com/fatih/color v1.12.0
go: downloading sigs.k8s.io/yaml v1.1.0
go: downloading gopkg.in/yaml.v2 v2.2.7
go: downloading github.com/mattn/go-isatty v0.0.12
go: downloading github.com/mattn/go-colorable v0.1.8
go: downloading golang.org/x/sys v0.1.0
ubuntu@node1:~/kube-prometheus$ 
```

```bash
ubuntu@node1:~/kube-prometheus$ ./build.sh jsonnetfile.json 
+ set -o pipefail
++ pwd
+ PATH=/home/ubuntu/kube-prometheus/tmp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/go/bin
+ rm -rf manifests
+ mkdir -p manifests/setup
+ jsonnet -J vendor -m manifests jsonnetfile.json
+ xargs '-I{}' sh -c 'cat {} | gojsontoyaml > {}.yaml' -- '{}'
+ find manifests -type f '!' -name '*.yaml' -delete
+ rm -f kustomization
ubuntu@node1:~/kube-prometheus$ 
```

```bash
ubuntu@node1:~/kube-prometheus$ kubectl apply --server-side -f manifests/setup
customresourcedefinition.apiextensions.k8s.io/alertmanagerconfigs.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/alertmanagers.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/podmonitors.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/probes.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/prometheuses.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/prometheusagents.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/prometheusrules.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/scrapeconfigs.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/servicemonitors.monitoring.coreos.com serverside-applied
customresourcedefinition.apiextensions.k8s.io/thanosrulers.monitoring.coreos.com serverside-applied
namespace/monitoring serverside-applied
```

```bash
ubuntu@node1:~/kube-prometheus$ kubectl apply -f manifests
alertmanager.monitoring.coreos.com/main created
networkpolicy.networking.k8s.io/alertmanager-main created
poddisruptionbudget.policy/alertmanager-main created
prometheusrule.monitoring.coreos.com/alertmanager-main-rules created
secret/alertmanager-main created
service/alertmanager-main created
serviceaccount/alertmanager-main created
servicemonitor.monitoring.coreos.com/alertmanager-main created
clusterrole.rbac.authorization.k8s.io/blackbox-exporter created
clusterrolebinding.rbac.authorization.k8s.io/blackbox-exporter created
configmap/blackbox-exporter-configuration created
deployment.apps/blackbox-exporter created
networkpolicy.networking.k8s.io/blackbox-exporter created
service/blackbox-exporter created
serviceaccount/blackbox-exporter created
servicemonitor.monitoring.coreos.com/blackbox-exporter created
secret/grafana-config created
secret/grafana-datasources created
configmap/grafana-dashboard-alertmanager-overview created
configmap/grafana-dashboard-apiserver created
configmap/grafana-dashboard-cluster-total created
configmap/grafana-dashboard-controller-manager created
configmap/grafana-dashboard-grafana-overview created
configmap/grafana-dashboard-k8s-resources-cluster created
configmap/grafana-dashboard-k8s-resources-multicluster created
configmap/grafana-dashboard-k8s-resources-namespace created
configmap/grafana-dashboard-k8s-resources-node created
configmap/grafana-dashboard-k8s-resources-pod created
configmap/grafana-dashboard-k8s-resources-workload created
configmap/grafana-dashboard-k8s-resources-workloads-namespace created
configmap/grafana-dashboard-kubelet created
configmap/grafana-dashboard-namespace-by-pod created
configmap/grafana-dashboard-namespace-by-workload created
configmap/grafana-dashboard-node-cluster-rsrc-use created
configmap/grafana-dashboard-node-rsrc-use created
configmap/grafana-dashboard-nodes-darwin created
configmap/grafana-dashboard-nodes created
configmap/grafana-dashboard-persistentvolumesusage created
configmap/grafana-dashboard-pod-total created
configmap/grafana-dashboard-prometheus-remote-write created
configmap/grafana-dashboard-prometheus created
configmap/grafana-dashboard-proxy created
configmap/grafana-dashboard-scheduler created
configmap/grafana-dashboard-workload-total created
configmap/grafana-dashboards created
deployment.apps/grafana created
networkpolicy.networking.k8s.io/grafana created
prometheusrule.monitoring.coreos.com/grafana-rules created
service/grafana created
serviceaccount/grafana created
servicemonitor.monitoring.coreos.com/grafana created
prometheusrule.monitoring.coreos.com/kube-prometheus-rules created
clusterrole.rbac.authorization.k8s.io/kube-state-metrics created
clusterrolebinding.rbac.authorization.k8s.io/kube-state-metrics created
deployment.apps/kube-state-metrics created
networkpolicy.networking.k8s.io/kube-state-metrics created
prometheusrule.monitoring.coreos.com/kube-state-metrics-rules created
service/kube-state-metrics created
serviceaccount/kube-state-metrics created
servicemonitor.monitoring.coreos.com/kube-state-metrics created
prometheusrule.monitoring.coreos.com/kubernetes-monitoring-rules created
servicemonitor.monitoring.coreos.com/kube-apiserver created
servicemonitor.monitoring.coreos.com/coredns created
servicemonitor.monitoring.coreos.com/kube-controller-manager created
servicemonitor.monitoring.coreos.com/kube-scheduler created
servicemonitor.monitoring.coreos.com/kubelet created
clusterrole.rbac.authorization.k8s.io/node-exporter created
clusterrolebinding.rbac.authorization.k8s.io/node-exporter created
daemonset.apps/node-exporter created
networkpolicy.networking.k8s.io/node-exporter created
prometheusrule.monitoring.coreos.com/node-exporter-rules created
service/node-exporter created
serviceaccount/node-exporter created
servicemonitor.monitoring.coreos.com/node-exporter created
clusterrole.rbac.authorization.k8s.io/prometheus-k8s created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-k8s created
networkpolicy.networking.k8s.io/prometheus-k8s created
poddisruptionbudget.policy/prometheus-k8s created
prometheus.monitoring.coreos.com/k8s created
prometheusrule.monitoring.coreos.com/prometheus-k8s-prometheus-rules created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s-config created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
rolebinding.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s-config created
role.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s created
role.rbac.authorization.k8s.io/prometheus-k8s created
service/prometheus-k8s created
serviceaccount/prometheus-k8s created
servicemonitor.monitoring.coreos.com/prometheus-k8s created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
clusterrole.rbac.authorization.k8s.io/prometheus-adapter created
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-adapter created
clusterrolebinding.rbac.authorization.k8s.io/resource-metrics:system:auth-delegator created
clusterrole.rbac.authorization.k8s.io/resource-metrics-server-resources created
configmap/adapter-config created
deployment.apps/prometheus-adapter created
networkpolicy.networking.k8s.io/prometheus-adapter created
poddisruptionbudget.policy/prometheus-adapter created
rolebinding.rbac.authorization.k8s.io/resource-metrics-auth-reader created
service/prometheus-adapter created
serviceaccount/prometheus-adapter created
servicemonitor.monitoring.coreos.com/prometheus-adapter created
clusterrole.rbac.authorization.k8s.io/prometheus-operator created
clusterrolebinding.rbac.authorization.k8s.io/prometheus-operator created
deployment.apps/prometheus-operator created
networkpolicy.networking.k8s.io/prometheus-operator created
prometheusrule.monitoring.coreos.com/prometheus-operator-rules created
service/prometheus-operator created
serviceaccount/prometheus-operator created
servicemonitor.monitoring.coreos.com/prometheus-operator created
ubuntu@node1:~/kube-prometheus$ 
```

Проверяю со своей ВМ:

```bash
sergo@ubuntu-pc:~/Work/diplom$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-648dffd99-m9qww   1/1     Running   0          67m
kube-system   calico-node-cs5qf                         1/1     Running   0          68m
kube-system   calico-node-svzbf                         1/1     Running   0          68m
kube-system   calico-node-xxsjb                         1/1     Running   0          68m
kube-system   coredns-69db55dd76-7j4d9                  1/1     Running   0          67m
kube-system   coredns-69db55dd76-jxtm2                  1/1     Running   0          67m
kube-system   dns-autoscaler-6f4b597d8c-npzmc           1/1     Running   0          67m
kube-system   kube-apiserver-node1                      1/1     Running   1          69m
kube-system   kube-controller-manager-node1             1/1     Running   2          69m
kube-system   kube-proxy-7q9qh                          1/1     Running   0          68m
kube-system   kube-proxy-8js7f                          1/1     Running   0          68m
kube-system   kube-proxy-fmw47                          1/1     Running   0          68m
kube-system   kube-scheduler-node1                      1/1     Running   1          69m
kube-system   nginx-proxy-node2                         1/1     Running   0          68m
kube-system   nginx-proxy-node3                         1/1     Running   0          68m
kube-system   nodelocaldns-lbxvs                        1/1     Running   0          67m
kube-system   nodelocaldns-m2v2p                        1/1     Running   0          67m
kube-system   nodelocaldns-rkkpp                        1/1     Running   0          67m
monitoring    alertmanager-main-0                       2/2     Running   0          89s
monitoring    alertmanager-main-1                       2/2     Running   0          89s
monitoring    alertmanager-main-2                       2/2     Running   0          89s
monitoring    blackbox-exporter-6b5475894-79kq7         3/3     Running   0          2m17s
monitoring    grafana-64c4f67f5b-m52fz                  1/1     Running   0          2m17s
monitoring    kube-state-metrics-65474fb4c6-252pd       3/3     Running   0          2m16s
monitoring    node-exporter-dpvfn                       2/2     Running   0          2m16s
monitoring    node-exporter-lwvbf                       2/2     Running   0          2m16s
monitoring    node-exporter-zz7pl                       2/2     Running   0          2m16s
monitoring    prometheus-adapter-74894c5547-kht97       1/1     Running   0          2m15s
monitoring    prometheus-adapter-74894c5547-qzf7r       1/1     Running   0          2m15s
monitoring    prometheus-k8s-0                          2/2     Running   0          87s
monitoring    prometheus-k8s-1                          2/2     Running   0          87s
monitoring    prometheus-operator-5575b484df-wvpv5      2/2     Running   0          2m15s
sergo@ubuntu-pc:~/Work/diplom$ 
```

Grafana доступна по ссылке: [http://51.250.107.247:30100/](http://51.250.107.247:30100/)

admin / 81837997

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/6.png"
  alt="image 6.png"
  title="image 6.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


[тестовое приложение - node-2](http://51.250.107.247:30200/)

[тестовое приложение - node-3](http://51.250.27.49:30200/)


[deploy.yaml](https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/deploy/deploy.yaml)


https://github.com/Serg2211/app/tree/main

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/7.png"
  alt="image 7.png"
  title="image 7.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">




---
### Установка и настройка CI/CD

Использовал [jenkins](https://www.jenkins.io/)

[Jenkins URL: http://158.160.57.38:8080/](http://158.160.57.38:8080/)

sergo / 81837997

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/8.png"
  alt="image 8.png"
  title="image 8.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


Создал Git Credentials и k8s-credentials

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/9.png"
  alt="image 9.png"
  title="image 9.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">

Добавил пользователя "jenkins" в docker group

```bash
ubuntu@jenkins:~$ docker version
Client:
 Version:           24.0.5
 API version:       1.43
 Go version:        go1.20.3
 Git commit:        24.0.5-0ubuntu1~22.04.1
 Built:             Mon Aug 21 19:50:14 2023
 OS/Arch:           linux/amd64
 Context:           default
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/version": dial unix /var/run/docker.sock: connect: permission denied
ubuntu@jenkins:~$ sudo docker version
Client:
 Version:           24.0.5
 API version:       1.43
 Go version:        go1.20.3
 Git commit:        24.0.5-0ubuntu1~22.04.1
 Built:             Mon Aug 21 19:50:14 2023
 OS/Arch:           linux/amd64
 Context:           default

Server:
 Engine:
  Version:          24.0.5
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.3
  Git commit:       24.0.5-0ubuntu1~22.04.1
  Built:            Mon Aug 21 19:50:14 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.7.2
  GitCommit:        
 runc:
  Version:          1.1.7-0ubuntu1~22.04.2
  GitCommit:        
 docker-init:
  Version:          0.19.0
  GitCommit:        
ubuntu@jenkins:~$ sudo gpasswd -a jenkins docker
Adding user jenkins to group docker
ubuntu@jenkins:~$ sudo service docker restart
ubuntu@jenkins:~$ 
```

	

Ожидаемый результат:

1. Интерфейс ci/cd сервиса доступен по http.

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/10.png"
  alt="image 10.png"
  title="image 10.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


2. При любом коммите в репозиторие с тестовым приложением происходит сборка и отправка в регистр Docker образа, а также деплой соответствующего Docker образа в кластер Kubernetes.

```bash
sergo@ubuntu-pc:~/Work/app$ git status
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   index.html

no changes added to commit (use "git add" and/or "git commit -a")
sergo@ubuntu-pc:~/Work/app$ git add --all
sergo@ubuntu-pc:~/Work/app$ git commit -m "Version 1.0.3"
[main 972a7da] Version 1.0.3
 1 file changed, 1 insertion(+), 1 deletion(-)
sergo@ubuntu-pc:~/Work/app$ git push -f https://github.com/Serg2211/app
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 291 bytes | 291.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/Serg2211/app
   98a7179..972a7da  main -> main
sergo@ubuntu-pc:~/Work/app$ 
```

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/11.png"
  alt="image 11.png"
  title="image 11.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/12.png"
  alt="image 12.png"
  title="image 12.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/13.png"
  alt="image 13.png"
  title="image 13.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/14.png"
  alt="image 14.png"
  title="image 14.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


3. Изменил pipeline, добавил Тег, сборка и отправка в регистр Docker образа, а также деплой соответствующего Docker образа в кластер Kubernetes.

```bash
sergo@ubuntu-pc:~/Work/app$ git status
On branch main
Your branch is ahead of 'origin/main' by 12 commits.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   index.html

no changes added to commit (use "git add" and/or "git commit -a")
sergo@ubuntu-pc:~/Work/app$ git add --all
sergo@ubuntu-pc:~/Work/app$ git commit -m "Version 1.0.15"
[main a3c9523] Version 1.0.15
 1 file changed, 1 insertion(+), 1 deletion(-)
sergo@ubuntu-pc:~/Work/app$ git tag -a v15.0 -m "Version 1.0.15"
sergo@ubuntu-pc:~/Work/app$ git push -f https://github.com/Serg2211/app
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 290 bytes | 290.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/Serg2211/app
   27c4bd8..a3c9523  main -> main
sergo@ubuntu-pc:~/Work/app$ git push -f https://github.com/Serg2211/app v15.0
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 164 bytes | 164.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/Serg2211/app
 * [new tag]         v15.0 -> v15.0
sergo@ubuntu-pc:~/Work/app$ 
```

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/15.png"
  alt="image 15.png"
  title="image 15.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px"> 


<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/16.png"
  alt="image 16.png"
  title="image 16.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px"> 


<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/17.png"
  alt="image 17.png"
  title="image 17.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">



---
## Что необходимо для сдачи задания?

1. Репозиторий с конфигурационными файлами Terraform и готовность продемонстрировать создание всех ресурсов с нуля.

[terraform](https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/terraform)

2. Пример pull request с комментариями созданными atlantis'ом или снимки экрана из Terraform Cloud или вашего CI-CD-terraform pipeline.

[Jenkinsfile](https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/jenkins/Jenkinsfile)

3. Репозиторий с конфигурацией ansible, если был выбран способ создания Kubernetes кластера при помощи ansible.

[ansible](https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/ansible)

4. Репозиторий с Dockerfile тестового приложения и ссылка на собранный docker image.

[Dockerfile](https://github.com/Serg2211/app/blob/main/Dockerfile)

5. Репозиторий с конфигурацией Kubernetes кластера.

[terraform](https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/terraform)

6. Ссылка на тестовое приложение и веб интерфейс Grafana с данными доступа.

[Grafana доступна по ссылке: http://51.250.107.247:30100/](http://51.250.107.247:30100/)

admin / 81837997

[Jenkins URL: http://158.160.57.38:8080/](http://158.160.57.38:8080/)

sergo / 81837997

[тестовое приложение - node-2](http://51.250.107.247:30200/)

[тестовое приложение - node-3](http://51.250.27.49:30200/)

[app_repo](https://github.com/Serg2211/app.git)

[DockerHub](https://hub.docker.com/repository/docker/sergo2211/app/general)

## Доработка

Если на первом этапе вы не воспользовались Terraform Cloud, то задеплойте и настройте в кластере atlantis для отслеживания изменений инфраструктуры. Альтернативный вариант 3 задания: вместо Terraform Cloud или atlantis настройте на автоматический запуск и применение конфигурации terraform из вашего git-репозитория в выбранной вами CI-CD системе при любом комите в main ветку. Предоставьте скриншоты работы пайплайна из CI/CD системы.

Создал отдельный [git-репозиторий](https://github.com/Serg2211/CI-CD) 

[All workflows](https://github.com/Serg2211/CI-CD/actions)

Все необходимые secrets добавил в Actions secrets and variables

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/18.png"
  alt="image 18.png"
  title="image 18.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


Как и договаривались сделал только terraform plan

```yaml
name: Terraform

on:
  push:
    branches:
      - main

jobs:
  terraform:
    name: Terraform
    runs-on: ubuntu-latest

    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.YC_ACCESS_KEY }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.YC_SECRET_KEY }}
      YC_TOKEN: ${{ secrets.YC_TOKEN }}
      ID_RSA: ${{ secrets.ID_RSA }}
      JENK_RSA: ${{ secrets.JENK_RSA }}
      working-directory: .
    defaults:
      run:
        working-directory: ${{ env.working-directory }}

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2

      - name: Save Ubuntu Public key to file for terraform
        run: echo $ID_RSA > id_rsa.pub

      - name: Save Jenkins SSH Public key to file for terraform
        run: echo $JENK_RSA > jenk.pub

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1
        with:
          terraform_version: 1.5.2

      - name: Terraform Init
        id: init
        run: terraform init

      - name: Terraform Plan
        id: plan
        run: terraform plan
```


```bash
sergo@ubuntu-pc:~/Work/diplom/CI-CD$ git commit -m "commit 19"
[main a6b72b8] commit 19
 1 file changed, 1 insertion(+), 1 deletion(-)
sergo@ubuntu-pc:~/Work/diplom/CI-CD$ git push -u origin main
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 289 bytes | 289.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:Serg2211/CI-CD.git
   b00866d..a6b72b8  main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
sergo@ubuntu-pc:~/Work/diplom/CI-CD$ 
```

<img
  src="https://github.com/Serg2211/devops-netology/blob/main/dz/diplom/images/19.png"
  alt="image 19.png"
  title="image 19.png"
  style="display: inline-block; margin: 0 auto; max-width: 600px">


terraform plan никаких изменений в инфраструктуре не увидел. Прделагает только создать локальный файл с настройками подключения к Backend

<details><summary>Вывод terraform plan</summary>

```bash
Run terraform plan
/home/runner/work/_temp/0d1c2f5d-8625-4116-bbd5-bd50de655c56/terraform-bin plan
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=04410c3a8b24d1b46f102994c4b693bf3c1fd5bc91afd60e510603073726d620]
data.yandex_compute_image.ubuntu-2204-lts: Reading...
yandex_vpc_network.network: Refreshing state... [id=enprqggd2v1paql9u4av]
yandex_iam_service_account.sergo-diplom: Refreshing state... [id=ajem9pfe02d88phcpia8]
yandex_kms_symmetric_key.key-a: Refreshing state... [id=abjsudgf0vnucbqqq7hp]
data.yandex_compute_image.ubuntu-2204-lts: Read complete after 3s [id=fd8hnnsnfn3v88bk0k1o]
yandex_resourcemanager_folder_iam_binding.encrypterDecrypter: Refreshing state... [id=b1gjsnlha3fii86tav22/kms.keys.encrypterDecrypter]
yandex_resourcemanager_folder_iam_binding.editor: Refreshing state... [id=b1gjsnlha3fii86tav22/editor]
yandex_iam_service_account_static_access_key.bucket-static_access_key: Refreshing state... [id=aje0lnhkjcqv9hkls5eo]
yandex_resourcemanager_folder_iam_binding.storage-admin: Refreshing state... [id=b1gjsnlha3fii86tav22/storage.admin]
yandex_storage_bucket.diplom-bucket: Refreshing state... [id=diplom-bucket]
yandex_vpc_subnet.subnet-2: Refreshing state... [id=e9baoaavr842usqpp4l9]
yandex_vpc_subnet.subnet-zones[1]: Refreshing state... [id=e2lpt5etkg6epbe5pa69]
yandex_vpc_subnet.subnet-zones[0]: Refreshing state... [id=e2laki7n2o25m09e7gmk]
yandex_compute_instance.jenkins: Refreshing state... [id=fhmokaokg1hophs0ah1k]
yandex_compute_instance.master-node: Refreshing state... [id=fhm1kqra63sj68r2rgte]
yandex_compute_instance.worker-nodes[0]: Refreshing state... [id=epdm73fldgskb4rcg322]
yandex_compute_instance.worker-nodes[1]: Refreshing state... [id=epdf69btc59e2ddb8cn5]
local_file.backendConf: Refreshing state... [id=b451e10b3b429138bed44ac0de20387ac785b76d]
yandex_storage_object.object-1: Refreshing state... [id=terraform/terraform.tfstate]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.backendConf will be created
  + resource "local_file" "backendConf" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./backend.key"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.

Warning: The `set-output` command is deprecated and will be disabled soon. Please upgrade to using Environment Files. For more information see: https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

Warning: The `set-output` command is deprecated and will be disabled soon. Please upgrade to using Environment Files. For more information see: https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

Warning: The `set-output` command is deprecated and will be disabled soon. Please upgrade to using Environment Files. For more information see: https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/
```

</details>
