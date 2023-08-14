terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.15.1"
    }
  }
}

provider "vultr" {
  api_key = var.vultr_api_key
}

resource "vultr_instance" "web" {
  count      = 1
  region     = "blr"
  plan       = "vc2-1c-1gb" # 1 vCPU, 1GB RAM
  os_id      = "1743"         # Ubuntu 22.04 x64
  activation_email = false
  hostname = "nnt-env"
  label = "nnt-env"
  ssh_key_ids = ["6ed065f0-112e-42e1-b9d9-59bbe7d9581a"]
  reserved_ip_id = "3e92ba6d-b2fb-4725-a9e5-6b2092087b18"

  user_data = <<-EOF

    #!/bin/bash

    # Update package list
    apt-get update

    # Your additional setup or commands here

  EOF
}
