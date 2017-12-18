#!/bin/bash -x

if [ "$1" = 'teampostgresql' ]; then
  cd /teampostgresql
  exec ./teampostgresql-run.sh
else
  exec "$@"
fi
