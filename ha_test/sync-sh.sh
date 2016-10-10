#!/bin/sh
for i in compute01 controller01 controller02 controller03; do 
scp -r /root/openstack/ha_test/ $i:/root/openstack/
done
