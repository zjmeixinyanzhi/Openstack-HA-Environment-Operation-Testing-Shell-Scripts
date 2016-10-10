#!/bin/sh
targethost=controller$1
service=mariadb.service
mysql -uroot -p123456 -h 192.168.100.201 -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
ssh $targethost systemctl status $service |grep Active:
ssh $targethost systemctl stop $service
ssh $targethost systemctl status $service |grep Active:
mysql -uroot -p123456 -h 192.168.100.201 -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
 . /root/keystonerc_admin
openstack token issue
ssh $targethost systemctl start $service
