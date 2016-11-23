#!/bin/sh
mysql -uroot -pGugong123 -h 192.168.2.211 -e "select @@hostname;"
mysql -uroot -pGugong123 -h 192.168.2.211 -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
for i in 01 02 03; do echo $i;ssh controller$i cat /var/lib/mysql/grastate.dat | grep seqno; done

