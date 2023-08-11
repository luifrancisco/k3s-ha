#!/bin/bash
pvesm free local-lvm:vm-1800-linstor-disk-1
pvesm free local-lvm:vm-1801-linstor-disk-1
pvesm free local-lvm:vm-1802-linstor-disk-1
pvesm alloc local-lvm 1800 'vm-1800-linstor-disk-1' 5G --format raw
pvesm alloc local-lvm 1801 'vm-1801-linstor-disk-1' 5G --format raw
pvesm alloc local-lvm 1802 'vm-1802-linstor-disk-1' 5G --format raw
qm set 1800 -scsi1 local-lvm:vm-1800-linstor-disk-1
qm set 1801 -scsi1 local-lvm:vm-1801-linstor-disk-1
qm set 1802 -scsi1 local-lvm:vm-1802-linstor-disk-1