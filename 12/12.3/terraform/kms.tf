resource "yandex_kms_symmetric_key" "key-a" {
  name              = "key_a"
  description       = "key_for_bucket"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
# не удаляет ключ terraform destroy
#  lifecycle {
#    prevent_destroy = true
#  }
}