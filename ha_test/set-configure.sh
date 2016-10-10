#!/bin/sh
### admin keyston认证脚本
openrc=/root/keystonerc_admin
### ha_test文件夹所在位置
base_location=/root/

### 已经存在虚拟机的子网IP
known_vm_private_ip=155.100.3.5

### 空闲的浮动IP
floating_ip=192.168.2.28

### HA VIP
vip=192.168.2.201

### HA VIP
external_network=public
### 新建网络的DNS
dns=8.8.8.8
