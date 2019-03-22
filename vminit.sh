#!/bin/bash

IP_ADDR=$1
HOST_NAME=$2
DNS_ADDR=$3

nmcli connection modify ens37 ipv4.addresses $IP_ADDR ipv4.dns ${DSN_ADDR:-114.114.114.114}
hostnamectl set-hostname $HOST_NAME
systemctl restart network
