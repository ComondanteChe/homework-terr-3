output "VM_info" {
  value = {
    name_db      = yandex_compute_instance.each_vm_instance.*.name
    fqdn_db               = yandex_compute_instance.each_vm_instance.*.fqdn
    instance_name_web     = yandex_compute_instance.web.*.name
    fqdn_web              = yandex_compute_instance.web.*.fqdn
    instance_name_storage = yandex_compute_instance.storage.name
    fqdn_storage          = yandex_compute_instance.storage.fqdn
  }
  
}