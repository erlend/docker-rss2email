#!/bin/sh
valid_args=new,email,add,run,list,pause,unpause,delete,reset,opmlimport,opmlexport
valid_r2e_argument () {
  echo $valid_args | tr , "\n" | grep -q ^$1$
}

if [ $# -eq 0 ]; then
  set -- r2e -h
elif [ "${1:0:1}" = "-" ] || valid_r2e_argument $1; then
  set -- r2e $@
fi

addgroup -g $PGID r2e
adduser -G r2e -u $PUID -D r2e

exec su-exec r2e $@
