data "template_file" "ansible_inventory" {
  template = file("${path.module}/hosts.tftpl")
  vars = {
    webservers = "${yandex_compute_instance.web}"
    database   = "${values(yandex_compute_instance.each_vm_instance)}"
    storage    = "${yandex_compute_instance.storage}"
  }
}

# resource "local_file" "ansible_inventory" {
#   content = templatefile("${path.module}/hosts.tftpl",
#      {webservers = yandex_compute_instance.web},
#      {database  = values(yandex_compute_instance.each_vm_instance)},
#      {storage   = yandex_compute_instance.storage}
#     )
#   filename = "${abspath(path.module)}/hosts.ini"
# }

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "${abspath(path.module)}/hosts.ini"
}