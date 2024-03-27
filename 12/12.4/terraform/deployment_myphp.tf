resource "local_file" "deployment" {
  content = <<-DOC
apiVersion: apps/v1
kind: Deployment
metadata:
  name: phpmyadmin-deployment
  labels:
    app: phpmyadmin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: phpmyadmin
  template:
    metadata:
      labels:
        app: phpmyadmin
    spec:
      containers:
        - name: phpmyadmin
          image: phpmyadmin/phpmyadmin
          resources:
             limits:
               cpu: 200m
               memory: 512Mi
             requests:
               cpu: 50m
               memory: 128Mi
          ports:
            - containerPort: 80
          env:
            - name: PMA_HOST
              value: "${yandex_mdb_mysql_cluster.my-mysql-3.host.0.fqdn}"
            - name: PMA_PORT
              value: "3306"
            - name: MYSQL_ROOT_PASSWORD
              value: "user1user1"
---
apiVersion: v1
kind: Service
metadata:
  name: phpmyadmin-service
spec:
  type: LoadBalancer
  selector:
    app: phpmyadmin
  ports:
  - name: http
    port: 80
    targetPort: 80
    DOC
  filename = "./myphp.yaml"

  depends_on = [
        yandex_mdb_mysql_cluster.my-mysql-3,
  ]
}