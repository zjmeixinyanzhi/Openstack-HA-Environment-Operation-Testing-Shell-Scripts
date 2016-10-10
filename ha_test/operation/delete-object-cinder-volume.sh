#!/bin/sh
. $openrc 
volumename=$1
rados -p volumes ls |grep $volumename|xargs rados -p volumes rm
openstack volume list
