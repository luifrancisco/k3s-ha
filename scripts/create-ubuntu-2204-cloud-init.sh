#!/bin/bash
# download the image

mkdir ~/images
cd ~/images
rm -f ~/images/jammy-server-cloudimg-amd64.img
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

#install qemu-guest-agent
virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent

# create a new VM with VirtIO SCSI controller
qm create 9000 --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci --name "ubuntu-22-04-template"

# import the downloaded disk to the local-lvm storage, attaching it as a SCSI drive
qm set 9000 --scsi0 local-lvm:0,import-from=/root/images/jammy-server-cloudimg-amd64.img


# **Ubuntu Cloud-Init images require the virtio-scsi-pci controller type for SCSI drives.**

# attach cd-rom(ide drive) for passing data to cloud-init image
qm set 9000 --ide2 local-lvm:cloudinit

# skip cd-rom checks and restrict VM to boot only from scsi drive.
qm set 9000 --boot order=scsi0


# configure serial console to output display
qm set 9000 --serial0 socket --vga serial0

# import public ssh key
#qm set 9000 --sshkeys /root/sshkeys/luis-dakanyama_id_rsa.pub

# enable qemu-agent
qm set 9000 --agent enabled=1

# convert VM to template
qm template 9000