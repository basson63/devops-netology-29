terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {  
  zone      = "var.yc_zone"
  folder_id   = var.yc_folder_id
}


# Create Service Account
resource "yandex_iam_service_account" "sa" {
  folder_id   = var.yc_folder_id
  name        = "sa"
  description = "Service account"
}

# Create Role "editor"
resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

# Create Role "storage-admin"
resource "yandex_resourcemanager_folder_iam_binding" "storage-admin" {
  folder_id = var.yc_folder_id
  role      = "storage.admin"
  members   = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

# Encription/decryption
resource "yandex_resourcemanager_folder_iam_binding" "encrypterDecrypter" {
  folder_id = var.yc_folder_id
  role      = "kms.keys.encrypterDecrypter"
  members   = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

# Create Static Access Key
resource "yandex_iam_service_account_static_access_key" "sa-static_key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "Static access key for object storage"
}

# KMS symmetric key for Storage Bucket.
resource "yandex_kms_symmetric_key" "key-a" {
  folder_id         = var.yc_folder_id
  name              = "symmetric-key"
  description       = "Simmetric key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
  lifecycle {
    prevent_destroy = false
  }
}

# Create Storage Bucket.
resource "yandex_storage_bucket" "diplom" {
  bucket     = "diplom"
  access_key = yandex_iam_service_account_static_access_key.sa-static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static_key.secret_key
  default_storage_class = "STANDARD"
  acl           = "public-read"
  force_destroy = "true"

  anonymous_access_flags {
    read = true
    list = true
    config_read = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

// Create "local_file" for "backend"
resource "local_file" "backend" {
  content  = <<EOT
endpoint = "storage.yandexcloud.net"
bucket = "${yandex_storage_bucket.diplom.bucket}"
region = "ru-central1-a"
key = "terraform/terraform.tfstate"
access_key = "${yandex_iam_service_account_static_access_key.sa-static_key.access_key}"
secret_key = "${yandex_iam_service_account_static_access_key.sa-static_key.secret_key}"
skip_region_validation = true
skip_credentials_validation = true
EOT
  filename = "./backend.key"
}

resource "yandex_storage_object" "object-2" {
    access_key = yandex_iam_service_account_static_access_key.sa-static_key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static_key.secret_key
    bucket = yandex_storage_bucket.diplom.bucket
    key = "terraform.tfstate"
    source = "./terraform.tfstate"
    acl    = "private"
    depends_on = [local_file.backend]
}
 
