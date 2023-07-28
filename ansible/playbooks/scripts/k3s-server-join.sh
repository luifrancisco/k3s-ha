#!/bin/bash
curl -sfL https://get.k3s.io | K3S_TOKEN=15700772202 sh -s - server --server https://k8s-master-0-dev:6443 --flannel-backend none --disable-network-policy