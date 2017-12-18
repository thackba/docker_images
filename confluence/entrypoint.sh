#!/bin/bash -x

if [ -n "${CONFLUENCE_PROXY_NAME}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@proxyName)]" --type attr -n proxyName --value "${CONFLUENCE_PROXY_NAME}" /opt/atlassian-confluence/atlassian-confluence/conf/server.xml
fi

if [ -n "${CONFLUENCE_PROXY_PORT}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@proxyPort)]" --type attr -n proxyPort --value "${CONFLUENCE_PROXY_PORT}" /opt/atlassian-confluence/atlassian-confluence/conf/server.xml
fi

if [ -n "${CONFLUENCE_PROXY_SCHEME}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@scheme)]" --type attr -n scheme --value "${CONFLUENCE_PROXY_SCHEME}" /opt/atlassian-confluence/atlassian-confluence/conf/server.xml
fi

if [ -n "${CONFLUENCE_CROWD_NAME}" ]  && [ -n "${CONFLUENCE_CROWD_PASSWORD}" ] && [ -n "${CONFLUENCE_CROWD_URL}" ]; then
  xmlstarlet ed -L --update "//authenticator/@class" --value "com.atlassian.confluence.user.ConfluenceCrowdSSOAuthenticator" /opt/atlassian-confluence/atlassian-confluence/confluence/WEB-INF/classes/seraph-config.xml
  cp /opt/atlassian-confluence/crowd_properties.template /opt/atlassian-confluence/atlassian-confluence/confluence/WEB-INF/classes/crowd.properties
  sed -i "s/%name%/${CONFLUENCE_CROWD_NAME}/g" /opt/atlassian-confluence/atlassian-confluence/confluence/WEB-INF/classes/crowd.properties
  sed -i "s/%password%/${CONFLUENCE_CROWD_PASSWORD}/g" /opt/atlassian-confluence/atlassian-confluence/confluence/WEB-INF/classes/crowd.properties
  sed -i "s/%url%/${CONFLUENCE_CROWD_URL}/g" /opt/atlassian-confluence/atlassian-confluence/confluence/WEB-INF/classes/crowd.properties
fi

if [ "$1" = 'confluence' ]; then
  exec /opt/atlassian-confluence/atlassian-confluence/bin/catalina.sh run
else
  exec "$@"
fi
