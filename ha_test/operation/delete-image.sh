#!/bin/sh
name=`uuidgen`
. $openrc
openstack image list
openstack image list |grep demo-image-cirros-|awk '{print $4}'|xargs openstack image delete
openstack image list
