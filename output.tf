output "VM_info" {
value = {
    name_db      = yandex_compute_instance.each_vm_instance.*.name
}
  
}