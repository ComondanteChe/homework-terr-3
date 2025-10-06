output "VM_info" {
value = {
    for vm in yandex_compute_instance.each_vm_instance : vm.name => {
      id          = vm.id
      name        = vm.name
      fqdn        = vm.fqdn
    }
}
  
}