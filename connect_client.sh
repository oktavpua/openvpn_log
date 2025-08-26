#!/bin/sh

date=`date +%d-%m-%Y_%T`
user=$common_name
remote_ip=$trusted_ip
local_ip=$ifconfig_pool_remote_ip
mac=$IV_HWADDR
mac_client=`cat /etc/openvpn/scripts/mac_list| grep $user | awk '{print $2}'`

#Раскомментировать следующуую строку и закомментировать все последующие, чтобы пользователь мог залогиниться и в логе появился его mac адрес
#echo $(date) $user login $remote_ip $local_ip $mac >> /etc/openvpn/scripts/login.log; exit 1

if [ ! -z ${IV_HWADDR+x} ]; then

    if [ "$mac" != "$mac_client" ]; then
        echo "$date $user trying to log in on UNREGISTERED device" >> /etc/openvpn/scripts/login.log; exit 1
   else
        echo $date $user SUCCESSFUL LOGIN $remote_ip $local_ip $mac >> /etc/openvpn/scripts/login.log; exit 0
    fi
else
    echo "$date $user MAC UNKNOWN. We need set push-peer-info option. $mac" >> /etc/openvpn/scripts/login.log; exit 1
fi
