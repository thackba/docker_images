FROM thackba/java:latest
MAINTAINER mail@thackbarth.net

ARG CROWD_VERSION=3.0.1
ARG CONTAINER_UID=1500
ARG CONTAINER_GID=1500

COPY entrypoint.sh /

WORKDIR /

RUN export CONTAINER_USER=crowd && \
    export CONTAINER_GROUP=crowd && \
    addgroup -gid $CONTAINER_GID $CONTAINER_GROUP && \
    adduser --system --home /home/$CONTAINER_USER --shell /bin/bash --uid $CONTAINER_UID --ingroup $CONTAINER_GROUP $CONTAINER_USER && \
    apt-get update && \
    apt-get install -y apt-utils wget xmlstarlet && \
    chmod 755 /entrypoint.sh && \
    mkdir -p /opt/atlassian-crowd && \
    mkdir -p /var/atlassian-crowd-home && \
    wget http://downloads.atlassian.com/software/crowd/downloads/atlassian-crowd-$CROWD_VERSION.tar.gz && \
    tar -xzf /atlassian-crowd-$CROWD_VERSION.tar.gz --directory /opt/atlassian-crowd && \
    rm /atlassian-crowd-$CROWD_VERSION.tar.gz && \
    chown -R crowd:crowd /opt/atlassian-crowd && \
    chown -R crowd:crowd /var/atlassian-crowd-home && \
    ln -s /opt/atlassian-crowd/atlassian-crowd-$CROWD_VERSION /opt/atlassian-crowd/atlassian-crowd && \
    echo "crowd.home=/var/atlassian-crowd-home" > /opt/atlassian-crowd/atlassian-crowd/crowd-webapp/WEB-INF/classes/crowd-init.properties && \
    apt-get clean && \
    rm -rf /var/lib/apt/* /tmp/* /var/tmp/* /var/cache/apt/*

USER crowd

EXPOSE 8095
VOLUME ["/var/atlassian-crowd-home"]
CMD ["/entrypoint.sh", "crowd"]
