#!/bin/bash -x

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
