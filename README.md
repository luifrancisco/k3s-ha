# k3s-ha

Welcome to my first homelab project. This repository contains all terraform and ansible scripts that will help you spin up your own kubernetes cluster with HA in place.

Terraform will be used to instantiate the VMs on Proxmox and Ansible to configure the cluster from scratch.

The terraform script by default will 3 VMs with two disks attached.

Pre-requisites:
- Kubernetes module for ansible (install with `ansible-galaxy collection install community.kubernetes`)
- Proxmox user to be used with terraform

How to use:
1. Download the repository
`git clone https://github.com/luifrancisco/k3s-ha`

2. Copy the file in k3s-ha/scripts directory to all the Proxmox nodes that will be used.
e.g.
```
cd k3s-ha/scripts
scp scripts/create-ubuntu-2204-cloud-init_pve0 pve0:~/scripts
scp scripts/create-ubuntu-2204-cloud-init_pve1 pve1:~/scripts
scp scripts/create-ubuntu-2204-cloud-init_pve2 pve2:~/scripts
```

3. Login to each proxmox node and change the ownership of the two files in the scripts direcyory.
```
chmod u+x create-ubuntu-2204-cloud-init.sh
```

4. Execute `create-ubuntu-2204-cloud-init.sh` shell script on main proxmox host.

5. Go to k3s-ha/terraform-linstor/terraform.tfvars and modify the token.

6. Modify main.tf and change the following according to requirement.
- resource
- name
- target_node
- ipconfig0 ip
- vmid
- cpu
- memory
- vlan
- vmbr
- disk.size

7. Modify k3s-ha/cilium-bgp yaml files
8. Modify k3s-ha/ansible/playbooks/site.yml
9. Modify ansible inventory in /etc/ansible/hosts.cfg or your own
```
all:
  hosts:
  children:
    main:
      hosts:
        10.20.0.30:
    members:
      hosts:
        10.20.0.31:
        10.20.0.32:
  vars:
    ansible_user: ansible
    _vip: 10.20.0.39
    _interface: eth0
    _clustercidr: 10.250.0.0/16
    _podcidr: 10.240.0.0/16
```
10. Modify k3s installation command for main and members. Change the hostname of the server for joining the members.

11. Modify site.yml and update IPs for /etc/hosts.

12. Execute below sequence:

```
ansible-playbook -i inventory.yml logical-volume-create.yml
ansible-playbook -i inventory.yml site.yml
ansible-playbook -i inventory.yml k3s-kubevip-helm-cilium-install.yml
ansible-playbook -i inventory.yml longhorn-install.yml
```