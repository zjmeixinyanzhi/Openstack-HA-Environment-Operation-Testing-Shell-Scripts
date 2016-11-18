#!/bin/sh
### admin keyston认证脚本
openrc=/root/keystonerc_admin
### ha_test文件夹所在位置
base_location=/root/

### 已经存在虚拟机的子网IP
known_vm_private_ip=155.100.3.3

### 空闲的浮动IP
floating_ip=192.168.2.126

### HA VIP
vip=192.168.2.211

### HA VIP
external_network=public
### 新建网络的DNS
dns=8.8.8.8
### 新建网络的网段
new_private_network=155.100.1.0/24
### 外部网络主机地址
external_host=www.baidu.com
