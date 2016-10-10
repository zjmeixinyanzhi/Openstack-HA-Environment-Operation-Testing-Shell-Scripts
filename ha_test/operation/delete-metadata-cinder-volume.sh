#!/bin/sh
. $openrc
openstack volume list
volumename=$1
volumeid=$(openstack volume list| grep $volumename |awk '{print $2}')
mysql -uroot -p123456 -h $vip -e  "DELETE FROM cinder.volume_admin_metadata WHERE volume_id ='$volumeid';"
mysql -uroot -p123456 -h $vip -e  "DELETE FROM cinder.volume_glance_metadata WHERE volume_id ='$volumeid';"
mysql -uroot -p123456 -h $vip -e  "DELETE FROM cinder.volume_attachment WHERE volume_id ='$volumeid';"
mysql -uroot -p123456 -h $vip -e  "DELETE FROM cinder.volume_glance_metadata where snapshot_id =(SELECT id FROM cinder.snapshots WHERE volume_id ='$volumeid');"
mysql -uroot -p123456 -h $vip -e  "DELETE FROM cinder.snapshots WHERE volume_id ='$volumeid';"
mysql -uroot -p123456 -h $vip -e  "DELETE FROM cinder.volumes WHERE id ='$volumeid';"
openstack volume list

