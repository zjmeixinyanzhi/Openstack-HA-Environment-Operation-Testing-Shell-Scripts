#!/bin/sh
name=`uuidgen`
. $openrc
neutron net-create demo-net-$name
neutron net-list
neutron subnet-create --name demo-subnet-$name --dns-nameserver $dns --gateway $(echo $new_private_network|cut -d "." -f1-3).1 $(neutron net-list|grep demo-net-|awk '{print $4}') $new_private_network
neutron subnet-list
neutron router-create demo-router-$name
neutron router-list
neutron router-interface-add $(neutron router-list |grep demo-router-|awk '{print $4}') $(neutron subnet-list|grep demo-subnet-|awk '{print $4}') 
neutron router-port-list $(neutron router-list |grep demo-router-|awk '{print $4}') 
neutron router-gateway-set $(neutron router-list |grep demo-router-|awk '{print $4}') $external_network
if [ $1 = "del"  ];then
echo "Do delete!"
neutron router-interface-delete $(neutron router-list |grep demo-router-|awk '{print $4}') $(neutron subnet-list|grep demo-subnet-|awk '{print $4}') 
neutron router-delete $(neutron router-list |grep demo-router-|awk '{print $4}')
neutron subnet-delete $(neutron subnet-list|grep demo-subnet-|awk '{print $4}')
neutron net-delete $(neutron net-list|grep demo-net-|awk '{print $4}')
fi
