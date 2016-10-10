#!/bin/sh
name=`uuidgen`
. $openrc 
cinder create --display-name demo-ceph-volume-$name --display-description "Cinder volume on Ceph" 2
cinder list
