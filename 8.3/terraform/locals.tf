locals {
 ssh_keys_and_serial_port = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
    serial-port-enable = 1
  }
} 
