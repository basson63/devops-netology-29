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