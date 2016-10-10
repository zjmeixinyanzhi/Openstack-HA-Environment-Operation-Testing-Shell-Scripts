#!/bin/sh
targethost=controller$1
service=$2
tag=$3
. /root/keystonerc_admin
openstack token issue
### stop service on target host
ssh $targethost systemctl status $service |grep Active:
ssh $targethost systemctl stop $service
ssh $targethost systemctl status $service |grep Active:
openstack token issue
#### get service on each hosts
for i in 01 02 03; do 
echo controller$i
ssh controller$i systemctl status $service |grep Active:
done
sleep 5
### restart service
if [ $tag = "start" ]; then
echo start $service on $targethost
ssh $targethost systemctl start $service
else 
echo "do not start" 
fi
