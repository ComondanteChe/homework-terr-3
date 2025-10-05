locals {
  ssh_key = file("/home/administrator/.ssh/id_ed25519.pub")
  image_id = data.yandex_compute_image.ubuntu.image_id
}