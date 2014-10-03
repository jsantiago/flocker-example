#!/bin/bash

ssh -t root@172.16.255.250 docker pull clusterhq/mongodb
ssh -t root@172.16.255.251 docker pull clusterhq/mongodb

ssh -t root@172.16.255.250 docker pull postgres
ssh -t root@172.16.255.251 docker pull postgres

ssh -t root@172.16.255.250 docker pull clusterhq/elasticsearch
ssh -t root@172.16.255.251 docker pull clusterhq/elasticsearch

ssh -t root@172.16.255.250 docker pull clusterhq/logstash
ssh -t root@172.16.255.251 docker pull clusterhq/logstash

ssh -t root@172.16.255.250 docker pull clusterhq/kibana
ssh -t root@172.16.255.251 docker pull clusterhq/kibana

ssh -t root@172.16.255.250 docker pull redis
ssh -t root@172.16.255.251 docker pull redis
