This is a dockerized Atlassian Confluence.

*Volumes*

- /var/atlassian-confluence-home - The home directory for Confluence data

*Environment Variables*

You can specify your reverse proxy host, port and scheme as environment variables. 
They will be pushed on startup in to the server.xml file of the underlying Apache Tomcat. 

- CONFLUENCE_PROXY_NAME
- CONFLUENCE_PROXY_PORT
- CONFLUENCE_PROXY_SCHEME

If you want do connect to Atlassian Crowd you can set the following variables:

- CONFLUENCE_CROWD_NAME
- CONFLUENCE_CROWD_PASSWORD
- CONFLUENCE_CROWD_URL (Slashes must be encoded with \\)


