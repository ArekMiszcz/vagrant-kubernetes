#!/bin/bash

# installing kubeadm, kubelet and kubectl
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# kubelet requires swap off
swapoff -a
    
# keep swap off after reboot
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
    
# ip of this box
IP_ADDR=`ip address show eth1 | grep -m 1 inet | awk '{print $2}' | cut -d / -f -1`
    
# set node-ip
echo "KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" >> /etc/default/kubelet
systemctl daemon-reload
systemctl restart kubelet
