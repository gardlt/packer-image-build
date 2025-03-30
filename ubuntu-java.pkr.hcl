variable "ubuntu_version" {
  default = "24.04"
}

source "virtualbox-iso" "ubuntu" {

  iso_urls = ["https://releases.ubuntu.com/${var.ubuntu_version}/ubuntu-${var.ubuntu_version}-live-server-amd64.iso"]
  iso_checksum = "sha256:d6dab0c3a657988501b4bd76f1297c053df710e06e0c3aece60dead24f270b4d"
  
  boot_command = [
    "<esc><wait>",
    "linux /casper/vmlinuz auto-install quiet ",
    "initrd=/casper/initrd ",
    "--- <enter>"
  ]

  shutdown_command = "sudo shutdown -P now"

  ssh_username = "ubuntu"
  ssh_password = "password"
  ssh_wait_timeout = "20m"
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install -y openjdk-21-jdk git maven",
      "sudo apt clean"
    ]
  }

  post-processor "vagrant" {
    output = "output/ubuntu-java.box"
  }
}