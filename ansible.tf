data "template_file" "ansible_inventory" {
  template = file("${path.module}/hosts.tftpl")
  vars = {
    webservers = var.yandex_computer_instance_web.name[*]
    database  = var.yandex_compute_instance_each_vm_instance.name[*]
    storage   = res.yandex_compute_instance.storage.name
  }
}

resource "local_file" "hosts_templatefile" {
  content = data.template_file.ansible_inventory.vars[*]
  filename = "${abspath(path.module)}/hosts.ini"
}