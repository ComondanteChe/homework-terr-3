data "template_file" "ansible_inventory" {
  template = file("${path.module}/hosts.tftpl",
    {webservers = yandex_computer_instance.web.name[*]},
    {database  = yandex_compute_instance_each_vm_instance.name[*]},
    {storage   = yandex_compute_instance_storage.name})
}

resource "local_file" "hosts_templatefile" {
  content = data.template_file.ansible_inventory.vars[*]
  filename = "${abspath(path.module)}/hosts.ini"
}