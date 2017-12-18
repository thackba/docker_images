FROM thackba/java:latest
MAINTAINER mail@thackbarth.net

ARG JIRA_VERSION=7.5.0
ARG CONTAINER_UID=1500
ARG CONTAINER_GID=1500

COPY entrypoint.sh /

WORKDIR /

RUN export CONTAINER_USER=jira && \
    export CONTAINER_GROUP=jira && \
    addgroup -gid $CONTAINER_GID $CONTAINER_GROUP && \
    adduser --system --home /home/$CONTAINER_USER --shell /bin/bash --uid $CONTAINER_UID --ingroup $CONTAINER_GROUP $CONTAINER_USER && \
    apt-get update && \
    apt-get install -y apt-utils wget xmlstarlet && \
    chmod 755 /entrypoint.sh && \
    mkdir -p /opt/atlassian-jira && \
    mkdir -p /var/atlassian-jira-home && \
    wget http://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-$JIRA_VERSION.tar.gz && \
    tar -xzf /atlassian-jira-software-$JIRA_VERSION.tar.gz --directory /opt/atlassian-jira && \
    rm /atlassian-jira-software-$JIRA_VERSION.tar.gz && \
    chown -R jira:jira /opt/atlassian-jira && \
    chown -R jira:jira /var/atlassian-jira-home && \
    ln -s /opt/atlassian-jira/atlassian-jira-software-${JIRA_VERSION}-standalone /opt/atlassian-jira/atlassian-jira && \
    echo "jira.home=/var/atlassian-jira-home" > /opt/atlassian-jira/atlassian-jira/atlassian-jira/WEB-INF/classes/jira-application.properties && \
    apt-get clean && \
    rm -rf /var/lib/apt/* /tmp/* /var/tmp/* /var/cache/apt/*

COPY crowd_properties.template /opt/atlassian-jira

USER jira

EXPOSE 8080
VOLUME ["/var/atlassian-jira-home"]
CMD ["/entrypoint.sh", "jira"]
