#!/bin/sh
targethost=compute$1
services="ceilometer-compute"
tag=$2
#services=$3
if [ $tag = "stop" ]; then
  echo "stop $services on $targethost"
  for iservice in $services;
  do
    echo "  >>"${iservice}
    ### stop service on target host
    ssh root@$targethost mv /usr/bin/ceilometer-polling /usr/bin/ceilometer-polling.bak
    ssh root@$targethost systemctl stop openstack-${iservice}
  done
else
  echo "restore $services on $targethost"
  for iservice in $services;
  do
    echo "  >>"${iservice}
    ### stop service on target host
    ssh root@$targethost mv /usr/bin/ceilometer-polling.bak /usr/bin/ceilometer-polling
    ssh root@$targethost systemctl start openstack-${iservice}
  done
fi

#### get service on each hosts
for i in 01 02 03;
do
  echo compute$i
  for service in $services;
  do
    echo "  "${service}
    ssh compute$i systemctl status openstack-${service} |grep Active:
  done
done

