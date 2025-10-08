resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl",
     {webservers = yandex_compute_instance.web
     database  = values(yandex_compute_instance.each_vm_instance)
     storage   = [yandex_compute_instance.storage]}
    )
  filename = "${abspath(path.module)}/hosts.ini"
}

resource "null_resource" "ansible_provision" {

    depends_on = [local_file.ansible_inventory, yandex_compute_instance.web, yandex_compute_instance.each_vm_instance, yandex_compute_instance.storage]

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/for.ini ${abspath(path.module)}/test.yml"
    on_failure = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
  triggers = {
    always_run      = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
     always_run_uuid = "${uuid()}"
    playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    # ssh_public_key = var.public_key # при изменении переменной with ssh 
    template_rendered = "${local_file.ansible_inventory.content}" #при изменении inventory-template
    password_change = jsonencode( {for k,v in random_password.each: k=>v
  }
}