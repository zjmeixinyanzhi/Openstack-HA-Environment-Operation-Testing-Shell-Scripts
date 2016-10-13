#!/bin/sh
. $openrc 
echo "Do delete!"
. $base_location/ha_test/operation/remove-floating-ip.sh
neutron router-interface-delete $(neutron router-list |grep demo-router-|awk '{print $4}') $(neutron subnet-list|grep demo-subnet-|awk '{print $4}') 
neutron router-delete $(neutron router-list |grep demo-router-|awk '{print $4}')
neutron router-list
nova volume-detach  $(openstack server list|grep demo-vm-|awk '{print $4}') $(openstack volume list|grep demo-ceph-volume-|awk '{print $2}')
openstack server delete $(openstack server list|grep demo-vm-|awk '{print $4}')
sed -i -e '/'"$floating_ip"'/d' /root/.ssh/known_hosts
openstack server list
neutron subnet-delete $(neutron subnet-list|grep demo-subnet-|awk '{print $4}')
neutron subnet-list
neutron net-delete $(neutron net-list|grep demo-net-|awk '{print $4}')
neutron net-list
openstack image list |grep demo-image-cirros-|awk '{print $4}'|xargs openstack image delete
openstack volume list|grep demo-ceph-volume-|awk '{print $4}'|xargs openstack volume delete 
openstack volume list
