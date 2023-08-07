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
  target_node = "pve1"
  clone = "ubuntu-22-04-template"
  vmid = 1800
  onboot = true
  tablet = false
  agent = 1
  memory = 8192
  sockets = 1
  cores = 4
  scsihw = "virtio-scsi-single"
  ciuser = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys
  ipconfig0 = "gw=10.20.0.1,ip=10.20.0.93/24"

  disk {
    type = "scsi"
    storage = "local-lvm"
	  size = "10G"
	  iothread = 1
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
  target_node = "pve1"
  clone = "ubuntu-22-04-template"
  vmid = 1801
  onboot = true
  tablet = false
  agent = 0
  memory = 8192
  sockets = 1
  cores = 4
  scsihw = "virtio-scsi-single"
  ciuser = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys
  ipconfig0 = "gw=10.20.0.1,ip=10.20.0.94/24"

  disk {
    type = "scsi"
    storage = "local-lvm"
	  size = "10G"
	  iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
}


resource "proxmox_vm_qemu" "k8s-master-1-dev" {
  name        = "k8s-master-1-dev"
  target_node = "pve1"
  clone = "ubuntu-22-04-template"
  vmid = 1801
  onboot = true
  tablet = false
  agent = 0
  memory = 8192
  sockets = 1
  cores = 4
  scsihw = "virtio-scsi-single"
  ciuser = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys
  ipconfig0 = "gw=10.20.0.1,ip=10.20.0.94/24"

  disk {
    type = "scsi"
    storage = "local-lvm"
	  size = "10G"
	  iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
}
