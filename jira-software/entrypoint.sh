#!/bin/bash -x

if [ -n "${JIRA_PROXY_NAME}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@proxyName)]" --type attr -n proxyName --value "${JIRA_PROXY_NAME}" /opt/atlassian-jira/atlassian-jira/conf/server.xml
fi

if [ -n "${JIRA_PROXY_PORT}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@proxyPort)]" --type attr -n proxyPort --value "${JIRA_PROXY_PORT}" /opt/atlassian-jira/atlassian-jira/conf/server.xml
fi

if [ -n "${JIRA_PROXY_SCHEME}" ]; then
  xmlstarlet ed -L --insert "//Connector[not(@scheme)]" --type attr -n scheme --value "${JIRA_PROXY_SCHEME}" /opt/atlassian-jira/atlassian-jira/conf/server.xml
fi

if [ -n "${JIRA_CROWD_NAME}" ]  && [ -n "${JIRA_CROWD_PASSWORD}" ] && [ -n "${JIRA_CROWD_URL}" ]; then
  xmlstarlet ed -L --update "//authenticator/@class" --value "com.atlassian.jira.security.login.SSOSeraphAuthenticator" /opt/atlassian-jira/atlassian-jira/atlassian-jira/WEB-INF/classes/seraph-config.xml
  cp /opt/atlassian-jira/crowd_properties.template /opt/atlassian-jira/atlassian-jira/atlassian-jira/WEB-INF/classes/crowd.properties
  sed -i "s/%name%/${JIRA_CROWD_NAME}/g" /opt/atlassian-jira/atlassian-jira/atlassian-jira/WEB-INF/classes/crowd.properties
  sed -i "s/%password%/${JIRA_CROWD_PASSWORD}/g" /opt/atlassian-jira/atlassian-jira/atlassian-jira/WEB-INF/classes/crowd.properties
  sed -i "s/%url%/${JIRA_CROWD_URL}/g" /opt/atlassian-jira/atlassian-jira/atlassian-jira/WEB-INF/classes/crowd.properties
fi

if [ "$1" = 'jira' ]; then
  exec /opt/atlassian-jira/atlassian-jira/bin/catalina.sh run
else
  exec "$@"
fi
