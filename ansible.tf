resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl",
    { webservers = yandex_compute_instance.web
      database  = values(yandex_compute_instance.each_vm_instance)
      storage   = [yandex_compute_instance.storage.name]
    })
  filename = "${abspath(path.module)}/hosts.ini"
}