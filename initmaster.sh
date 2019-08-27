#!/bin/bash

# ip of this box
IP_ADDR=`ip address show eth1 | grep -m 1 inet | awk '{print $2}' | cut -d / -f -1`

# hostname of this box
HOST_NAME=$(hostname -s)

# install k8s master
kubeadm init --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=192.168.0.0/16
