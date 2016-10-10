#!/bin/sh
. /root/keystonerc_admin
openstack token issue
openstack server list
openstack network list
openstack compute service list
openstack-status
nova list
neutron agent-list
cinder list
ceph -s
ceph df

