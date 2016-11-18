#!/bin/sh
targethost=controller$1
services="cinder-api cinder-scheduler cinder-backup cinder-volume"
tag=$2
#services=$3
if [ $tag = "stop" ]; then
  echo "stop $services on $targethost"
  for iservice in $services;
  do
    echo "  >>"${iservice}
    ### stop service on target host
    ssh root@$targethost mv /usr/bin/${iservice} /usr/bin/${iservice}.bak
    ssh root@$targethost systemctl stop openstack-${iservice}
  done
else
  echo "restore $services on $targethost"
  for iservice in $services;
  do
    echo "  >>"${iservice}
    ### stop service on target host
    ssh root@$targethost mv /usr/bin/${iservice}.bak /usr/bin/${iservice}
    ssh root@$targethost systemctl start openstack-${iservice}
  done
fi

#### get service on each hosts
for i in 01 02 03;
do
  echo controller$i
  for service in $services;
  do
    echo "  "${service}
    ssh controller$i systemctl status openstack-${service} |grep Active:
  done
done

