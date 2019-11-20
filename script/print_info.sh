#!/bin/bash

echo -e "\n##### date #####"
date

echo -e "\n##### locale #####"
locale

echo -e "\n##### relase #####"
cat /etc/*release

echo -e "\n##### uname #####"
uname -a

echo -e "\n##### pwd #####"
pwd

echo -e "\n##### id #####"
id

echo -e "\n##### env #####"
env

echo -e "\n##### /proc/cpuinfo #####"
cat /proc/cpuinfo

echo -e "\n##### /proc/meminfo #####"
cat /proc/meminfo

echo -e "\n##### df -h #####"
df -h

echo -e "\n##### ls -l / #####"
ls -l /

echo -e "\n##### ls -l . #####"
ls -l .

echo -e "\n##### docker version #####"
docker version

echo -e "\n##### docker info #####"
docker info

# echo -e "\n##### docker-compose version #####"
# docker-compose version
