initialize() {
  /home/nbpmon/noms/nsight_jp/bin/noms_nsight -stop
  /etc/init.d/crond stop
  /etc/init.d/rsyslog stop
}

stress_test() {
  TEST_CPU_NUM=$(($(cat /proc/cpuinfo|grep -c 'processor') - 1))
  TEST_MEM_SIZE=$(echo "$(/usr/bin/free|grep cache:|awk '{print $4}') * 0.95"|bc -l|awk -F"." '{print $1}')
  /usr/bin/stress --timeout $1 --cpu $TEST_CPU_NUM --vm 1 --vm-bytes ${TEST_MEM_SIZE}K --vm-keep &

  VENDOR=$(/usr/sbin/dmidecode| grep Product|head -n 1 |awk '{print $3}')
  if [ "$VENDOR" == "PowerEdge" ]; then
    DISKS=$(df|grep "^/dev"|sort -nrk 2,2|uniq -w8|awk '{print $6}')
  elif [ "$VENDOR" == "ProLiant" ]; then
    DISKS=$(df|grep "^/dev"|sort -nrk 2,2|uniq -w16|awk '{print $6}')
  else
    DISKS=$(df|grep "^/dev"|sort -nrk 2,2|uniq -w8|awk '{print $6}')
  fi
  for disk in $DISKS; do
    cd $disk
    test_disk_size=$(echo "$(df $disk|awk '{print $4}') * 0.95"|/usr/bin/bc -l|awk -F"." '{print $1}')
    /usr/bin/stress --timeout $1 --hdd 1 --hdd-bytes ${test_disk_size}K &
  done

  while [ $(ps -ef | grep -c "/usr/bin/[s]tress") -ne 0 ]; do
    sleep 60
  done
}

if [ -z "$1" ];then
  TEST_SECOND=$((24 * 60 * 60))
else
  TEST_SECOND=$(($1 * 60 * 60))
fi

initialize
stress_test $TEST_SECOND
