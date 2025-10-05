variable "each_vm" {
  type = map(object({
    name          = string
    platform_id   = string
    zone          = string
    cores         = number
    memory        = number
    core_fraction = number
    boot_disk = object({
      type = string
      size = number
    })
    nat           = bool
    scheduling_policy = bool
    ssh_user      = string
    }))
    default = {
      "main" = { 
        name          = "main"
        platform_id   = "standard-v3"
        zone          = "ru-central1-a"
        cores         = 2
        memory        = 1
        core_fraction = 20
        boot_disk = {
          type = "network-hdd"
          size = 10
        }
        nat           = true
        scheduling_policy = true
        ssh_user      = "ubuntu"
        }
      "replica" = { 
        name          = "replica"
        platform_id   = "standard-v3"
        zone          = "ru-central1-a"
        cores         = 3
        memory        = 2
        core_fraction = 20
        boot_disk = {
          type = "network-hdd"
          size = 15
        }
        nat           = true
        scheduling_policy = true
        ssh_user      = "ubuntu"
        }
    }
}

resource "yandex_compute_instance" "each_vm_instance" {
  for_each = var.each_vm
    name    = each.value.name
    palatform_id = each.value.platform_id
  resources {
    cores        = each.value.cores
    memory       = each.value.memory
    core_fraction = each.value.core_fraction
    boot_disk = each.value.boot_disk
    image         = local.image_id
    subnet_id     = yandex_vpc_subnet.develop.id
    nat           = each.value.nat
    scheduling_policy = each.value.scheduling_policy
    ssh_user      = each.value.ssh_user
    ssh_key       = local.ssh_key
    zone        = each.value.zone
}
}
