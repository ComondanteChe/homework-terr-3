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
    image_id      = string
    subnet_id     = string
    nat           = bool
    scheduling_policy = bool
    ssh_user      = string
    ssh_key       = string
    }))
    default = {
      "main" = { 
        name          = "main"
        platform_id   = "standard-v3"
        zone          = "ru-central1-a"
        cores         = 2
        memory        = 1
        core_fraction = 20
        image_id    = local.image_id
        boot_disk = {
          type = "network-hdd"
          size = 10
        }
        subnet_id     = yandex_vpc_subnet.develop.id
        nat           = true
        scheduling_policy = true
        ssh_user      = "ubuntu"
        ssh_key       = local.ssh_key
        }
      "replica" = { 
        name          = "replica"
        platform_id   = "standard-v3"
        zone          = "ru-central1-a"
        cores         = 3
        memory        = 2
        core_fraction = 20
        image_id
        boot_disk = {
          type = "network-hdd"
          size = 15
        }
        subnet_id     = yandex_vpc_subnet.develop.id
        nat           = true
        scheduling_policy = true
        ssh_user      = "ubuntu"
        ssh_key       = local.ssh_key
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
    image         = each.value.image
    subnet_id     = each.value.subnet_id
    nat           = each.value.nat
    scheduling_policy = each.value.scheduling_policy
    ssh_user      = each.value.ssh_user
    ssh_key       = each.value.ssh_key
    zone        = each.value.zone
}
}
