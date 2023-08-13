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

  user_data = <<-EOF

    #!/bin/bash

    # Update package list
    apt-get update

    # Your additional setup or commands here

  EOF
}
