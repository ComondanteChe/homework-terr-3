resource "yandex_compute_disk" "disk_storage" {
    count = 3
        name  = "disk-storage-${count.index + 1}"
        type  = "network-hdd"
        size  = 1
}

resource "yandex_compute_instance" "storage" {
    name        = "storage"
    platform_id = "standard-v1"
    zone        = "ru-central1-a"
    resources {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }
    dynamic secondary_disk {
      for_each = yandex_compute_disk.disk_storage
      boot_disk {
            initialize_params {
              disk_id = secondary_disk.value.id
            }
        }
    }    
    scheduling_policy { preemptible = true }
    network_interface {
      subnet_id = yandex_vpc_subnet.develop.id
      nat       = true
      security_group_ids = [yandex_vpc_security_group.example.id]
    }
    metadata = {
      serial-port-enable = 1
      ssh-keys = "${local.ssh_user}:${local.ssh_key}"
    } 
}