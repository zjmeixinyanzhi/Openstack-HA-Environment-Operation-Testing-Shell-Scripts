#!/bin/sh
targethost=controller$1
service=$2
tag=$3
. /root/keystonerc_admin
openstack token issue
### stop service on target host
ssh $targethost systemctl status neutron-openvswitch-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service neutron-ovs-cleanup.service neutron-server.service neutron-netns-cleanup.service neutron-l3-agent.service|grep Active:
ssh $targethost systemctl stop neutron-openvswitch-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service neutron-ovs-cleanup.service neutron-server.service neutron-netns-cleanup.service neutron-l3-agent.service
ssh $targethost systemctl status neutron-openvswitch-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service neutron-ovs-cleanup.service neutron-server.service neutron-netns-cleanup.service neutron-l3-agent.service|grep Active:
openstack token issue
#### get service on each hosts
for i in 01 02 03; do 
echo controller$i
ssh controller$i systemctl status neutron-openvswitch-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service neutron-ovs-cleanup.service neutron-server.service neutron-netns-cleanup.service neutron-l3-agent.service |grep Active:
done
#### create vm
#/root/openstack/ha_test/operation/common-create-vm-add-fip-ping.sh
#/root/openstack/ha_test/operation/network-integration-test.sh

### restart service
if [ $tag = "start" ]; then
echo start $service on $targethost
ssh $targethost systemctl start neutron-openvswitch-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service neutron-ovs-cleanup.service neutron-server.service neutron-netns-cleanup.service neutron-l3-agent.service
else 
echo "do not start" 
fi
