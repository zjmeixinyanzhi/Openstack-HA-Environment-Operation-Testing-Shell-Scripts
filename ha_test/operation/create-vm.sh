#!/bin/sh
name=`uuidgen`
. $openrc 
openstack server create --flavor m1.tiny --image cirros.raw --nic net-id=$(openstack network list |grep private|head -n 1|awk '{print $2}') --security-group default demo-vm-$name
