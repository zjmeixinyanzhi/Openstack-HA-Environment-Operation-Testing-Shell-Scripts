#!/bin/sh
targethost=controller$1
services="httpd"
tag=$2
#services=$3
if [ $tag = "stop" ]; then
  echo "stop $services on $targethost"
  for iservice in $services;
  do
    echo "  >>"${iservice}
    ### stop service on target host
    ssh root@$targethost mv /usr/sbin/${iservice} /usr/sbin/${iservice}.bak 
    ssh root@$targethost systemctl stop ${iservice}
  done
else
  echo "restore $services on $targethost"
  for iservice in $services;
  do
    echo "  >>"${iservice}
    ### stop service on target host
    ssh root@$targethost mv /usr/sbin/${iservice}.bak /usr/sbin/${iservice}
    ssh root@$targethost systemctl start ${iservice}
  done
fi

#### get service on each hosts
for i in 01 02 03;
do 
  echo controller$i
  for service in $services;
  do
    echo "  "${service}
    ssh controller$i systemctl status ${service} |grep Active:
  done
done
