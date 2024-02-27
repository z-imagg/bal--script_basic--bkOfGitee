#!/bin/sh

#有线网卡速度设置为千兆全双工、ip地址设置为172.18.0.x

function WiredNetCardSetup(){

#若函数参数少于2个，则退出（退出码为45）
[ $# -lt 2 ] && return 45

netCardName=$1
ip_SubNetWidth=$2

#重置网卡
sudo ethtool --negotiate $netCardName
#$netCardName , such as :enp4s0

#这里可能要拔掉网线 重新插入网线
read -p "拔掉网线后按回车(以继续执行)"

#千兆 全双共 自动协商
sudo ethtool  -s $netCardName speed 1000 duplex full autoneg  on

#u22d机 删除网卡配置 并添加IP地址
sudo ip addr flush dev $netCardName
sudo ip addr add $ip_SubNetWidth dev $netCardName
#$ip_SubNetWidth , such as : 172.18.0.230/24  

#确认已设置为 千兆
#ethtool $netCardName| grep -i speed

}


#mecherev(机械革命：i7 12代 16G内存，内存尺寸 已经表达在ip地址中了 已增加ip地址可读性) host:
sudo lshw  | grep -i mechrevo   && WiredNetCardSetup enp4s0 192.168.113.16/24

#shinelon(炫龙：i7 4代 8G内存，内存尺寸 已经表达在ip地址中了 已增加ip地址可读性) host:
sudo lshw  | grep -i shinelon && WiredNetCardSetup enp5s0 192.168.113.8/24

grep "shinelon_mechrev" /etc/hosts || echo "
#直接网线连接 : direct wired line.
#shinelon_mechrev
192.168.113.8   shinelon shn s  server.host
192.168.113.16  mechrev mcr d desktop.host
" | sudo tee -a /etc/hosts
