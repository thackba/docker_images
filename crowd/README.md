This is a dockerized Atlassian Crowd.

*Volumes*

- /var/atlassian-crowd-home - The home directory for Crowd data

*Environment Variables*

You can specify your reverse proxy host, port and scheme as environment variables. 
They will be pushed on startup in to the server.xml file of the underlying Apache Tomcat. 

- CROWD_PROXY_NAME
- CROWD_PROXY_PORT
- CROWD_PROXY_SCHEME
