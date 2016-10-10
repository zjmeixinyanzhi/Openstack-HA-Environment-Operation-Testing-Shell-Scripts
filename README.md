Openstack-HA-Environment-Operation-Testing-Shell-Scripts为Openstack HA环境下测试各服务组件高可用性的shell脚本集，通过这些脚本可以方便地进行各组件的高可用的测试。

Openstack HA配置参考：http://docs.openstack.org/ha-guide/index.html

1、文件目录结构
ha_test
├── 0-set-configure.sh                     ### 设置本地环境变量
├── get-service-status.sh                  ### 获取服务状态
├── list-all.sh                            ### 列出Openstack云资源
├── operation                              
│   ├── add-floating-ip.sh                 ### 添加浮动IP
│   ├── all-integration.sh                 ### 综合操作脚本
│   ├── cirros.raw                         ### 用于镜像操作测试
│   ├── common-create-vm-add-fip-ping.sh   ### 创建虚拟机相关操作
│   ├── create-cinder.sh                   ### 创建卷
│   ├── create-images.sh                   ### 创建镜像
│   ├── create-net.sh                      ### 创建private网
│   ├── create-vm.sh                       ### 创建虚拟机
│   ├── delete-all-intergration.sh         ### 删除综合操作产生的资源
│   ├── delete-cinder.sh                   ### 删除测试创建的卷
│   ├── delete-image.sh                    ### 删除测试创建的镜像
│   ├── delete-intergration.sh             ### 删除集成操作产生的资源
│   ├── delete-metadata-cinder-volume.sh   ### 强制删除卷的资源
│   ├── delete-net.sh                      ### 删除测试产生的网络
│   ├── delete-object-cinder-volume.sh     ### 删除ceph中卷对象
│   ├── delete-vm.sh                       ### 删除虚拟机
│   ├── network-integration-test.sh        ### 网络集成测试
│   ├── pingvm.sh                          ### 网络连通测试
│   └── remove-floating-ip.sh              ### 移除绑定在虚拟机的浮动IP
├── restart-pcs-cluster.sh                 ### 重启pacemaker集群
├── restart-service.sh                     ### 重启控制节点上的服务
├── start-service.sh                       ### 启动控制节点上的服务
├── stop-pcs-cluster.sh                    ### 停止pacemaker集群
├── stop-service.sh                        ### 停止控制节点上的服务
├── sync-sh.sh                             ### 同步脚本到其他控制节点
├── test-cinder.sh                         ### cinder服务停止测试
├── test-gelera-cluster-db.sh              ### mariadb的gelera集群测试
├── test-glance.sh                         ### glance服务停止测试
├── test-httpd.sh                          ### httpd服务停止测试
├── test-neutron.sh                        ### neutron服务停止测试
├── test-nova.sh                           ### nova服务停止测试
└── test-rabbitmq-server.sh                ### rabbitmq服务停止测试


ha_test目录：环境变量设置、停止控制节点服务脚本
operation目录：Openstack常用操作

all-integration.sh：创建镜像、private网络、路由器、浮动IP、卷、虚拟机的集成脚本

2、用法

（1）根据实际的Openstack HA平台环境，修改配置文件中实际环境变量，并初始化测试变量

$ vim 0-set-configure.sh
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

$ . 0-set-configure.sh

（2）执行ha_test目录下的测试脚本test-XXX
参数为停止哪个控制节点上的哪个服务
参数格式为：参数1（所停止控制节点的编号） 参数2（所停止服务的名称） 参数3（是否重启该服务，若是填"start"）
例如：
# . test-neutron.sh 01 start
或
# . stop-service.sh 02 neutron-openvswitch-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service neutron-ovs-cleanup.service neutron-server.service neutron-netns-cleanup.service neutron-l3-agent.service

（3）执行operation目下的操作脚本，查看输出
# . operation/all-integration.sh

（4）执行operation目下的删除脚本，删除测试产生的资源
# . operation/delete-all-intergration.sh




