# k3s-ha

Welcome to my first major homelab project. This repository contains all terraform and ansible scripts that will help you spin up your own kubernetes cluster with HA in place.

Terraform will be used to instantiate the VMs on Proxmox and Ansible to configure the cluster from scratch.

The terraform script by default will 3 VMs with two disks attached.

How to use:
1. Download the repository
`git clone https://github.com/luifrancisco/k3s-ha`

2. Copy the two files in k3s-ha/scripts directory to all the Proxmox nodes that will be used.
e.g.
```
cd k3s-ha
scp -r scripts/ pve0:~/
scp -r scripts/ pve1:~/
scp -r scripts/ pve2:~/
```

3. Login to each proxmox node and change the ownership of the two files in the scripts direcyory.
```
chmod u+x create-ubuntu-2204-cloud-init.sh
chmod u+x attach-second-disk.sh
```

4. 
