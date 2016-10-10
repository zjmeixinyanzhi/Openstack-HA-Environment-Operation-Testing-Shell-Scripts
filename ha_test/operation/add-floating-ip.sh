#!/bin/sh
openstack ip floating add $floating_ip $(openstack server list|grep demo-vm-|awk '{print $4}')
ping -c 5 $floating_ip
