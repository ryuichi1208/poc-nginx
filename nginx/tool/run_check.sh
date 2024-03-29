#!/bin/bash -x

function log() {
  local fname=${BASH_SOURCE[1]##*/}
  echo -e "$(date '+%Y-%m-%dT%H:%M:%S') ${fname}:${BASH_LINENO[0]}:${FUNCNAME[1]} $@"
}

log-eval () {
    echo \$ "$@"
    eval "$@"
}

log-exec () {
    echo \$ "$@"
    exec "$@"
}

rkill () {
    local signal=$1; shift
    local pid=$1; shift
    local notpid=$1; shift

    if children="$(pgrep -P "$pid")"; then
        for child in $children; do
            rkill "$signal" "$child" "$notpid"
        done
    fi
    if [ "$pid" != "$notpid" ]; then
        kill -s "$signal" "$pid"
    fi
}
