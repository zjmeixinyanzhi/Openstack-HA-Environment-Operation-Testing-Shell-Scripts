#!/bin/sh
. $openrc
vmname=$1
vmid=$(openstack server list| grep $vmname |awk '{print $2}')
openstack server list
mysql -uroot -p123456 -h $vip -e  "delete from nova.instance_system_metadata where instance_uuid ='$vmid';"
mysql -uroot -p123456 -h $vip -e  "delete from nova.instance_info_caches where instance_uuid ='$vmid';"
mysql -uroot -p123456 -h $vip -e  "delete from nova.instance_extra where  instance_uuid ='$vmid';"
mysql -uroot -p123456 -h $vip -e  "delete from nova.instance_faults where  instance_uuid ='$vmid';"
mysql -uroot -p123456 -h $vip -e  "select id from nova.instance_actions where  instance_uuid ='$vmid';"
mysql -uroot -p123456 -h $vip -e  "delete from nova.instance_actions_events where action_id =(select id from  nova.instance_actions where  instance_uuid ='$vmid');"
mysql -uroot -p123456 -h $vip -e  "delete from nova.instance_actions where  instance_uuid ='$vmid';"
mysql -uroot -p123456 -h $vip -e  "delete from nova.block_device_mapping where instance_uuid ='$vmid';"
mysql -uroot -p123456 -h $vip -e  "delete from nova.instances where id ='$vmid';"
openstack server list
echo "ssh ceph client do \"rados -p vms ls |grep $vmid|xargs rados -p vms rm\""
