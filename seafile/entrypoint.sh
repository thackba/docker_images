#!/bin/bash -x

if [ ! -d /opt/seafile/seafile-server-${SEAFILE_VERSION} ]; then
    tar -xzf /seafile-server_${SEAFILE_VERSION}_x86-64.tar.gz --directory /opt/seafile
fi

if   [ "$1" = 'seafile' ]; then
  cat > /opt/seafile/seafile-start.sh <<EOF
#!/bin/bash

/opt/seafile/seafile-server-${SEAFILE_VERSION}/seafile.sh start
EOF
  cat > /opt/seafile/seahub-start.sh << EOF
#!/bin/bash

sleep 5
/opt/seafile/seafile-server-${SEAFILE_VERSION}/seahub.sh start
EOF
  chmod 755 /opt/seafile/*-start.sh
  exec /usr/bin/supervisord -j /opt/seafile/supervisor.pid  -l /opt/seafile/supervisor.log
elif [ "$1" = 'firstrun' ]; then
  /opt/seafile/seafile-server-${SEAFILE_VERSION}/seafile.sh start
  /opt/seafile/seafile-server-${SEAFILE_VERSION}/seahub.sh start
elif [ "$1" = 'setup' ]; then
  exec /opt/seafile/seafile-server-${SEAFILE_VERSION}/setup-seafile-mysql.sh
else
  exec "$@"
fi
