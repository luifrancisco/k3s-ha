terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  # Configuration options
  pm_api_url = "https://10.20.0.4:8006/api2/json/"
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
}

## Use aliases to provision on different pve nodes
# provider "proxmox" {
#   # Configuration options
#   alias = "pve0"
#   pm_api_url = "https://10.0.0.10:8006/api2/json/"
#   pm_api_token_id = var.pm_api_token_id
#   pm_api_token_secret = var.pm_api_token_secret
# }

# provider "proxmox" {
#   # Configuration options
#   alias = "pve1"
#   pm_api_url = "https://10.0.0.11:8006/api2/json/"
#   pm_api_token_id = var.pm_api_token_id
#   pm_api_token_secret = var.pm_api_token_secret
# }

# provider "proxmox" {
#   # Configuration options
#   alias = "pve2"
#   pm_api_url = "https://10.0.0.12:8006/api2/json/"
#   pm_api_token_id = var.pm_api_token_id
#   pm_api_token_secret = var.pm_api_token_secret
# }

variable "ciuser" {
    type = string
}

variable "cipassword" {
    type = string
}

variable "pm_api_token_id" {
    type = string
}
variable "pm_api_token_secret" {
    type = string
}

variable "sshkeys" {
    type = string
}

resource "proxmox_vm_qemu" "k8s-master-0-dev" {
  name        = "k8s-master-0-dev"
  target_node = "pve-dev"
  clone = "ubuntu-22-04-template"
  vmid = 1800
  onboot = true
  tablet = false
  agent = 1
  memory = 4096
  sockets = 1
  cores = 4
  scsihw = "virtio-scsi-single"
  ciuser = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys
  ipconfig0 = "gw=10.20.0.1,ip=10.20.0.90/24"

  disk {
    type = "scsi"
    storage = "local-lvm"
	  size = "10G"
	  iothread = 1
    ssd = 1
  }

 disk {
   type = "scsi"
   storage = "local-lvm"
   size = "20G"
   iothread = 1
   ssd = 1
 }

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
}



# Commenting below to test cicustom
resource "proxmox_vm_qemu" "k8s-master-1-dev" {
  name        = "k8s-master-1-dev"
  target_node = "pve-dev"
  clone = "ubuntu-22-04-template"
  vmid = 1801
  onboot = true
  tablet = false
  agent = 0
  memory = 4096
  sockets = 1
  cores = 4
  scsihw = "virtio-scsi-single"
  ciuser = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys
  ipconfig0 = "gw=10.20.0.1,ip=10.20.0.91/24"

  disk {
    type = "scsi"
    storage = "local-lvm"
	  size = "10G"
	  iothread = 1
    ssd = 1
  }

 disk {
   type = "scsi"
   storage = "local-lvm"
   size = "20G"
   iothread = 1
   ssd = 1
 }

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
}


resource "proxmox_vm_qemu" "k8s-master-2-dev" {
  name        = "k8s-master-2-dev"
  target_node = "pve-dev"
  clone = "ubuntu-22-04-template"
  vmid = 1802
  onboot = true
  tablet = false
  agent = 0
  memory = 4096
  sockets = 1
  cores = 4
  scsihw = "virtio-scsi-single"
  ciuser = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys
  ipconfig0 = "gw=10.20.0.1,ip=10.20.0.92/24"

  disk {
    type = "scsi"
    storage = "local-lvm"
	  size = "10G"
	  iothread = 1
    ssd = 1
  }

 disk {
   type = "scsi"
   storage = "local-lvm"
   size = "20G"
   iothread = 1
   ssd = 1
 }

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
}
