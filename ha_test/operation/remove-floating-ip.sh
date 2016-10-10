#!/bin/sh
openstack ip floating remove $floating_ip $(openstack server list|grep demo-vm-|awk '{print $4}')
ping -c 3 $floating_ip
