#!/bin/sh
targethost=controller$1
service=$2
tag=$3
. /root/keystonerc_admin
openstack token issue
### stop service on target host
ssh $targethost systemctl status openstack-glance-api openstack-glance-registry |grep Active:
ssh $targethost systemctl stop openstack-glance-api openstack-glance-registry
ssh $targethost systemctl status openstack-glance-api openstack-glance-registry |grep Active:
openstack token issue
#### get service on each hosts
for i in 01 02 03; do 
echo controller$i
ssh controller$i systemctl status openstack-glance-api openstack-glance-registry |grep Active:
done
#/root/openstack/ha_test/operation/create-images.sh del
### restart service
if [ $tag = "start" ]; then
echo start $service on $targethost
ssh $targethost systemctl start openstack-glance-api openstack-glance-registry
else 
echo "do not start" 
fi
