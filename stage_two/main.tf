terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.0" # Use the latest version available
    }
  }
}
provider "null" {}

resource "null_resource" "server-start" {
  provisioner "local-exec" {
    command = <<EOT
      vagrant init ubuntu/jammy64
      vagrant up
    EOT
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}
resource "null_resource" "playbook" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "paps"
      private_key = file("~/.ssh/id_rsa")
      host        = "127.0.0.1"
    }
    inline = [
      "ansible-playbook -i /home/paps/Devops/yolo/stage_two/playbook.yaml"
      ]
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}
resource "null_resource" "kill" {
  provisioner "local-exec" {
    command = "vagrant destroy -f"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}