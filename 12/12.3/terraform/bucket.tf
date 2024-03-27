resource "yandex_iam_service_account" "ladmin" {
  name = "ladmin"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.yc_folder_id
  role = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.ladmin.id}"
  ]
  depends_on = [
    yandex_iam_service_account.ladmin,
  ]
}

resource "yandex_iam_service_account_static_access_key" "static-access-key" {
  service_account_id = yandex_iam_service_account.ladmin.id
  depends_on = [
    yandex_iam_service_account.ladmin,
  ]
}

resource "yandex_storage_bucket" "backet-vitnek" {
  bucket = "backet-vitnek"
  force_destroy = true
  access_key = yandex_iam_service_account_static_access_key.static-access-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.static-access-key.secret_key
  acl        = "public-read-write"
  max_size   = 10000000
  #шифрование
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  depends_on = [
    yandex_iam_service_account_static_access_key.static-access-key
  ]
}

resource "yandex_storage_object" "backet-ogon" {
  access_key = yandex_iam_service_account_static_access_key.static-access-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.static-access-key.secret_key
  bucket     = "backet-vitnek"
  key        = "ogon.jpg"
  source     = "./ogon.jpg"
  acl        = "public-read-write"
  depends_on = [
    yandex_storage_bucket.backet-vitnek
  ]
}

resource "yandex_storage_bucket" "test" {
  bucket = "vitnek.ru"
  acl    = "public-read"
  access_key = yandex_iam_service_account_static_access_key.static-access-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.static-access-key.secret_key
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  depends_on = [
    yandex_iam_service_account_static_access_key.static-access-key
  ]
}

resource "yandex_storage_object" "index-html" {
  access_key = yandex_iam_service_account_static_access_key.static-access-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.static-access-key.secret_key
  bucket     = "vitnek.ru"
  key        = "index.html"
  source     = "./index.html"
  acl        = "public-read-write"
  depends_on = [
    yandex_storage_bucket.test
  ]
}

resource "yandex_storage_object" "ogon2" {
  access_key = yandex_iam_service_account_static_access_key.static-access-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.static-access-key.secret_key
  bucket     = "vitnek.ru"
  key        = "ogon.jpg"
  source     = "./ogon.jpg"
  acl        = "public-read-write"
  depends_on = [
    yandex_storage_bucket.test
  ]
}

resource "yandex_storage_object" "error" {
  access_key = yandex_iam_service_account_static_access_key.static-access-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.static-access-key.secret_key
  bucket     = "vitnek.ru"
  key        = "error.html"
  source     = "./error.html"
  acl        = "public-read-write"
  depends_on = [
    yandex_storage_bucket.test
  ]
}