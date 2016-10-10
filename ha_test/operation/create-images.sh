#!/bin/sh
name=`uuidgen`
. $openrc 
openstack image list
openstack image create "image-cirros-"$name   --file $base_location/ha_test/operation/cirros.raw --disk-format raw --container-format bare   --public
openstack image list
if [ $1="del" ];then
openstack image delete $(openstack image list |grep image-cirros|awk '{print $4}')
openstack image list
fi
