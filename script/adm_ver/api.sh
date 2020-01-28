#!/bin/bash

user=$USER
page=`curl -sL http://qiita.com/${user}/following_users | grep data-pjax | tail -n 1 | cut -d "?" -f 2 | cut -d '"' -f 1 | cut -d = -f 2`

following=$(for (( i=1;i<=${page};i++ ))
do
    html=`curl -sL "http://qiita.com/${user}/following_users?page=${i}" | grep 'span itemprop="name"' | tr '>' '\n' | grep -A1 'itemprop="name"' |cut -d '<' -f -1`
    echo "$html"
done)

followers=$(for (( i=1;i<=${page};i++ ))
do
    html=`curl -sL "http://qiita.com/${user}/followers?page=${i}" | grep 'span itemprop="name"' | tr '>' '\n' | grep -A1 'itemprop="name"' |cut -d '<' -f -1`
    echo "$html"
done)

d=`echo "$following"`
d=$d`echo "$followers"`
user=`echo "$d"|sort | uniq -u`

case $user in
    "") echo ok ;;
    *)  echo "http://qiita.com/${user}" ;;
esac
