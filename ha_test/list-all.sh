#!/bin/sh
. /root/keystonerc_admin
openstack server list
neutron net-list
neutron subnet-list
neutron router-list
openstack image list
cinder list

