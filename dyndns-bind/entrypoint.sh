#!/bin/bash -x

if [ "$1" = 'bind9' ]; then
  mkdir -p /data/cache
  if [ -f /data/dyndns.zones ]; then
    touch /data/dyndns.zones
  fi
  if [ ! -f /data/dyndns.key ]; then
    touch /data/dyndns.key
  fi
  chown -R root:bind /data
  chown -R bind:bind /data/cache
  service bind9 start
  su -c "python3 /dyndns-update.py" dyndns
else
  exec "$@"
fi
