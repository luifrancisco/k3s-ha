#!/bin/bash
curl -sfL https://get.k3s.io | K3S_TOKEN=15700772202 sh -s - server --cluster-init --flannel-backend none --disable-network-policy
