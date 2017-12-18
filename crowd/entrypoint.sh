#!/bin/bash -x

if [ -n "${CROWD_PROXY_NAME}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@proxyName)]" --type attr -n proxyName --value "${CROWD_PROXY_NAME}" /opt/atlassian-crowd/atlassian-crowd/apache-tomcat/conf/server.xml
fi

if [ -n "${CROWD_PROXY_PORT}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@proxyPort)]" --type attr -n proxyPort --value "${CROWD_PROXY_PORT}" /opt/atlassian-crowd/atlassian-crowd/apache-tomcat/conf/server.xml
fi

if [ -n "${CROWD_PROXY_SCHEME}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@scheme)]" --type attr -n scheme --value "${CROWD_PROXY_SCHEME}" /opt/atlassian-crowd/atlassian-crowd/apache-tomcat/conf/server.xml
fi

if [ "$1" = 'crowd' ]; then
  exec /opt/atlassian-crowd/atlassian-crowd/apache-tomcat/bin/catalina.sh run
else
  exec "$@"
fi
