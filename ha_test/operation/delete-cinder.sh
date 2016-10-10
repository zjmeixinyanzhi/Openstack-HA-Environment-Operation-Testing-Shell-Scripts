#!/bin/sh
. $openrc 
openstack volume list
openstack volume delete $(openstack volume list|grep demo-ceph-volume-|awk '{print $4}')
openstack volume list
