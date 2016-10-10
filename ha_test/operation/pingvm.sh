#!/usr/bin/expect -f
ssh cirros@$floating_ip ping -c 5 $known_vm_private_ip

