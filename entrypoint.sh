#!/bin/bash

set -x

cmd=$1
shift

if [[ "$cmd" != "" ]]; then
    # if first arg is an executable then run it
    if [[ -n "$(echo $cmd | grep /)" && -x $cmd ]]; then
        exec $cmd $@
    else
        # search $PATH for $cmd
        for dir in ${PATH//:/ }; do
            if [[ -x "$dir/$cmd" ]]; then
                exec "$dir/$cmd" $@
            fi
        done
    fi
fi

config=''
if [[ -r /etc/dmrlink.cfg ]]; then
    config="--config /etc/dmrlink.cfg"
fi

exec python ./dmrlink.py $config $cmd $@
