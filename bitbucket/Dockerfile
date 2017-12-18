FROM thackba/java:latest
MAINTAINER mail@thackbarth.net

ARG BITBUCKET_VERSION=5.4.0
ARG CONTAINER_UID=1500
ARG CONTAINER_GID=1500

ENV BITBUCKET_HOME=/var/atlassian-bitbucket-home
ENV BITBUCKET_USER=bitbucket
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle

COPY entrypoint.sh /

WORKDIR /

RUN export CONTAINER_USER=bitbucket && \
    export CONTAINER_GROUP=bitbucket && \
    addgroup -gid $CONTAINER_GID $CONTAINER_GROUP && \
    adduser --system --home /home/$CONTAINER_USER --shell /bin/bash --uid $CONTAINER_UID --ingroup $CONTAINER_GROUP $CONTAINER_USER && \
    apt-get update && \
    apt-get install -y apt-utils git wget xmlstarlet && \
    chmod 755 /entrypoint.sh && \
    mkdir -p /opt/atlassian-bitbucket && \
    mkdir -p /var/atlassian-bitbucket-home && \
    wget http://downloads.atlassian.com/software/stash/downloads/atlassian-bitbucket-$BITBUCKET_VERSION.tar.gz && \
    tar -xzf /atlassian-bitbucket-$BITBUCKET_VERSION.tar.gz --directory /opt/atlassian-bitbucket && \
    rm /atlassian-bitbucket-$BITBUCKET_VERSION.tar.gz && \
    chown -R bitbucket:bitbucket /opt/atlassian-bitbucket && \
    chown -R bitbucket:bitbucket /var/atlassian-bitbucket-home && \
    ln -s /opt/atlassian-bitbucket/atlassian-bitbucket-${BITBUCKET_VERSION} /opt/atlassian-bitbucket/atlassian-bitbucket && \
    apt-get clean && \
    rm -rf /var/lib/apt/* /tmp/* /var/tmp/* /var/cache/apt/*

USER bitbucket

EXPOSE 7990
EXPOSE 7999

VOLUME ["/var/atlassian-bitbucket-home"]
CMD ["/entrypoint.sh", "bitbucket"]
