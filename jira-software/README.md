This is a dockerized Atlassian JIRA Software.

*Volumes*

- /var/atlassian-jira-home - The home directory for JIRA data

*Environment Variables*

You can specify your reverse proxy host, port and scheme as environment variables. 
They will be pushed on startup in to the server.xml file of the underlying Apache Tomcat. 

- JIRA_PROXY_NAME
- JIRA_PROXY_PORT
- JIRA_PROXY_SCHEME

If you want do connect to Atlassian Crowd you can set the following variables:

- JIRA_CROWD_NAME
- JIRA_CROWD_PASSWORD
- JIRA_CROWD_URL (Slashes must be encoded with \\)


