data "template_file" "ansible_inventory" {
  template = file("${path.module}/hosts.tftpl")
  vars = {
    webservers = local.yandex_computer_instance.web.name[*]
    database  = local.yandex_compute_instance_each_vm_instance.name[*]
    storage   = local.yandex_compute_instance_storage.name
  }
}

resource "local_file" "hosts_templatefile" {
  content = data.template_file.ansible_inventory.vars[*]
  filename = "${abspath(path.module)}/hosts.ini"
}