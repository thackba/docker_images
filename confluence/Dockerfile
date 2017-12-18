FROM thackba/java:latest
MAINTAINER mail@thackbarth.net

ARG CONFLUENCE_VERSION=6.4.0
ARG CONTAINER_UID=1500
ARG CONTAINER_GID=1500

COPY entrypoint.sh /

WORKDIR /

RUN export CONTAINER_USER=confluence && \
    export CONTAINER_GROUP=confluence && \
    addgroup -gid $CONTAINER_GID $CONTAINER_GROUP && \
    adduser --system --home /home/$CONTAINER_USER --shell /bin/bash --uid $CONTAINER_UID --ingroup $CONTAINER_GROUP $CONTAINER_USER && \
    apt-get update && \
    apt-get install -y apt-utils graphviz wget xmlstarlet && \
    chmod 755 /entrypoint.sh && \
    mkdir -p /opt/atlassian-confluence && \
    mkdir -p /var/atlassian-confluence-home && \
    wget http://downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-$CONFLUENCE_VERSION.tar.gz && \
    tar -xzf /atlassian-confluence-$CONFLUENCE_VERSION.tar.gz --directory /opt/atlassian-confluence && \
    rm /atlassian-confluence-$CONFLUENCE_VERSION.tar.gz && \
    chown -R confluence:confluence /opt/atlassian-confluence && \
    chown -R confluence:confluence /var/atlassian-confluence-home && \
    ln -s /opt/atlassian-confluence/atlassian-confluence-${CONFLUENCE_VERSION} /opt/atlassian-confluence/atlassian-confluence && \
    echo "confluence.home=/var/atlassian-confluence-home" > /opt/atlassian-confluence/atlassian-confluence/confluence/WEB-INF/classes/confluence-init.properties && \
    apt-get clean && \
    rm -rf /var/lib/apt/* /tmp/* /var/tmp/* /var/cache/apt/*

COPY crowd_properties.template /opt/atlassian-confluence

USER confluence

EXPOSE 8090
EXPOSE 8091

VOLUME ["/var/atlassian-confluence-home"]
CMD ["/entrypoint.sh", "confluence"]
