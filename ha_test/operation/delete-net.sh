#!/bin/sh
. $openrc 
echo "Do delete!"
. $base_location/ha_test/operation/remove-floating-ip.sh
neutron router-interface-delete $(neutron router-list |grep demo-router-|awk '{print $4}') $(neutron subnet-list|grep demo-subnet-|awk '{print $4}') 
neutron router-delete $(neutron router-list |grep demo-router-|awk '{print $4}')
neutron router-list
neutron subnet-delete $(neutron subnet-list|grep demo-subnet-|awk '{print $4}')
neutron subnet-list
neutron net-delete $(neutron net-list|grep demo-net-|awk '{print $4}')
neutron net-list
