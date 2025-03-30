source "virtualbox-vm" "java_iso" {
  iso_url = "output/ubuntu-java.box"
}

build {
  sources = ["source.virtualbox-vm.java_iso"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "git clone https://github.com/example/repo.git app",
      "cd app",
      "mvn clean install",
      "java -jar target/app.jar"
    ]
  }
}