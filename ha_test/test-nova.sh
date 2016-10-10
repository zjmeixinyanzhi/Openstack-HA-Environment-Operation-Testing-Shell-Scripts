#!/bin/sh
targethost=controller$1
service=$2
tag=$3
. /root/keystonerc_admin
openstack token issue
### stop service on target host
ssh $targethost systemctl status openstack-nova-api openstack-nova-scheduler openstack-nova-conductor openstack-nova-novncproxy openstack-nova-consoleauth|grep Active:
ssh $targethost systemctl stop openstack-nova-api openstack-nova-scheduler openstack-nova-conductor openstack-nova-novncproxy openstack-nova-consoleauth
ssh $targethost systemctl status openstack-nova-api openstack-nova-scheduler openstack-nova-conductor openstack-nova-novncproxy openstack-nova-consoleauth|grep Active:
openstack token issue
#### get service on each hosts
for i in 01 02 03; do 
echo controller$i
ssh controller$i systemctl status openstack-nova-api openstack-nova-scheduler openstack-nova-conductor openstack-nova-novncproxy openstack-nova-consoleauth |grep Active:
done
#### create vm
#/root/openstack/ha_test/operation/common-create-vm-add-fip-ping.sh

### restart service
if [ $tag = "start" ]; then
echo start $service on $targethost
ssh $targethost systemctl start openstack-nova-api openstack-nova-scheduler openstack-nova-conductor openstack-nova-novncproxy openstack-nova-consoleauth
else 
echo "do not start" 
fi
