#!/bin/sh
valid_args=new,email,add,run,list,pause,unpause,delete,reset,opmlimport,opmlexport
valid_r2e_argument () {
  echo $valid_args | tr , "\n" | grep -q ^$1$
}

export XDG_CONFIG_HOME=${CONFIG_PATH:-/data}
export XDG_DATA_HOME=${DATA_PATH:-/data}

if [ $# -eq 0 ]; then
  set -- r2e -h
elif [ "${1:0:1}" = "-" ] || valid_r2e_argument $1; then
  set -- r2e $@
fi

addgroup -g $PGID r2e
adduser -G r2e -u $PUID -D r2e

mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME
chown -Rf r2e:r2e $XDG_CONFIG_HOME $XDG_DATA_HOME

exec su-exec r2e $@
