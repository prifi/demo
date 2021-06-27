#!/bin/bash
MasterIP1=10.100.1.11
MasterIP2=10.1.3.131
MasterIP3=10.1.3.132
MasterPort=6443

docker run -d --restart=always --name HAProxy-K8S -p 6444:6444 \
        -e MasterIP1=$MasterIP1 \
        -e MasterIP2=$MasterIP2 \
        -e MasterIP3=$MasterIP3 \
        -e MasterPort=$MasterPort \
        #-v `pwd`/etc/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
        wise2c/haproxy-k8s
