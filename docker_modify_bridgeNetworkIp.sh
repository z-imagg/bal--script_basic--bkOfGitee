#!/usr/bin/env bash

# docker设置 桥接网络 ip地址
sudo docker network rm bridge

#注意 172.17.0.1/24 其实是默认的, 这里只是演示其由来，也为了能让172.17.0.1被搜索到 而不是凭空出现的。

#修改 桥接网络 ip地址 方法1
#sudo docker network create --driver=bridge --subnet=172.17.0.0/24 --gateway=172.17.0.1 docker0

#修改 桥接网络 ip地址 方法2
sudo apt install -y jq
docker_daemon_conf_F=/etc/docker/daemon.json
jq '. += {  "bip": "172.17.0.1/24"  }' $docker_daemon_conf_F | sudo tee $docker_daemon_conf_F

sudo systemctl start docker
_end=true


