#!/bin/sh
name=`uuidgen`
. $openrc 
openstack server list
openstack server create --flavor m1.tiny --image cirros.raw --nic net-id=$(openstack network list |grep private|awk '{print $2}') --security-group default demo-vm-$name
openstack ip floating add $floating_ip $(openstack server list|grep demo-vm-|awk '{print $4}')
openstack server list
ping -c 5 $floating_ip
ssh cirros@$floating_ip ping -c 5 $known_vm_private_ip

