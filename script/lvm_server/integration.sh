#!/bin/bash

set -ve
export GOPATH=~/go
export GO111MODULE=off
export GOTAGS=cmount

mkdir -p ${GOPATH}/src/github.com/rclone/rclone
cd ${GOPATH}/src/github.com/rclone/rclone
rm -f fs/operations/operations.test fs/sync/sync.test fs/test_all.log summary test.log

if [ -e ".git" ]; then
    git stash --include-untracked # stash any local changes just in case
    git checkout master
    git pull
else
    git clone https://github.com/rclone/rclone.git .
fi

make
go get -u github.com/restic/restic/...

minio_dir=/tmp/minio

killall -q minio || true
rm -rf ${minio_dir}
mkdir -p ${minio_dir}
for i in 1 2 3 4 5; do GO111MODULE=on go get github.com/minio/minio@latest command && break || sleep 2; done
minio server --address 127.0.0.1:9000 ${minio_dir} >/tmp/minio.log 2>&1 &
minio_pid=$!

go install github.com/rclone/rclone/fstest/test_all

test_all -verbose -upload "memstore:pub-rclone-org//integration-tests" -email "nick@craig-wood.com" -output "/home/rclone/integration-test/rclone-integration-tests"

kill $minio_pid
