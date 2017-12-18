#!/bin/bash -x

if [ "$1" = '7days' ]; then
  /steamcmd/steamcmd.sh +login anonymous +force_install_dir /server +app_update 294420 validate +quit
  if [ ! -f /home/steam/serverconfig.xml ]; then
    cp /server/serverconfig.xml /home/steam/serverconfig.xml
  fi
  /server/7DaysToDieServer.x86_64 -logfile /dev/stdout -configfile=/home/steam/serverconfig.xml -quit -batchmode -nographics -dedicated
else
  exec "$@"
fi
