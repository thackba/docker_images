FROM ubuntu:xenial
MAINTAINER mail@thackbarth.net

ARG CONTAINER_UID=1500
ARG CONTAINER_GID=1500

ENV DEBIAN_FRONTEND=noninteractive
ENV SEAFILE_VERSION=6.1.2

COPY entrypoint.sh /

WORKDIR /

RUN export CONTAINER_USER=seafile && \
    export CONTAINER_GROUP=seafile && \
    addgroup -gid $CONTAINER_GID $CONTAINER_GROUP && \
    adduser --system --home /home/$CONTAINER_USER --shell /bin/bash --uid $CONTAINER_UID --ingroup $CONTAINER_GROUP $CONTAINER_USER && \
    apt-get update && \
    apt-get install -y python wget python2.7 libpython2.7 python-setuptools python-imaging python-ldap python-mysqldb python-memcache python-urllib3 supervisor && \
    mkdir -p /opt/seafile && \
    wget https://download.seadrive.org/seafile-server_${SEAFILE_VERSION}_x86-64.tar.gz && \
    chmod 755 /entrypoint.sh && \
    chown -R seafile:seafile /opt/seafile && \
    apt-get clean && \
    rm -rf /var/lib/apt/* /tmp/* /var/tmp/* /var/cache/apt/*

COPY supervisord.conf /etc/

USER seafile

VOLUME ["/opt/seafile"]
EXPOSE 8000/tcp 8082/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["seafile"]



