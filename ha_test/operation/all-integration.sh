#!/bin/sh
name=`uuidgen`
. $openrc
. $base_location/ha_test/operation/create-net.sh no
openstack image create "demo-image-cirros-"$name   --file $base_location/ha_test/operation/cirros.raw --disk-format raw --container-format bare   --public
openstack server create --flavor m1.tiny --image $(openstack image list |grep demo-image-cirros-|awk '{print $4}') --nic net-id=$(openstack network list |grep demo-net- |awk '{print $2}') --security-group default demo-vm-$name
openstack ip floating add $floating_ip $(openstack server list|grep demo-vm-|awk '{print $4}')
openstack server list
ssh cirros@$floating_ip ping -c 5 $(echo $new_private_network|cut -d "." -f1-3).1
ssh cirros@$floating_ip ping -c 5 $external_host
cinder create --display-name demo-ceph-volume-$name --display-description "Cinder volume on Ceph" 2
cinder list
nova volume-attach $(openstack server list|grep demo-vm-|awk '{print $4}') $(openstack volume list|grep demo-ceph-volume-|awk '{print $2}') 
echo "ssh cirros@$floating_ip sudo fdisk -l"
ssh cirros@$floating_ip

