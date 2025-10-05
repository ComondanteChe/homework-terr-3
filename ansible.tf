data "template_file" "ansible_inventory" {
  template = file("${path.module}/hosts.tftpl")
    vars = {
    webservers = yandex_computer_instance.web[*]
    database  = yandex_compute_instance.each_vm_instance[*]
    storage   = yandex_compute_instance_storage
    }
}

resource "local_file" "hosts_templatefile" {
  content = data.template_file.ansible_inventory.vars[*]
  filename = "${abspath(path.module)}/hosts.ini"
}