#!/bin/sh
name=`uuidgen`
. $openrc 
openstack server list
. $base_location/ha_test/operation/remove-floating-ip.sh
openstack server delete $(openstack server list|grep demo-vm-|awk '{print $4}')
sed -i -e '/$floating_ip/d' /root/.ssh/known_hosts
openstack server list
