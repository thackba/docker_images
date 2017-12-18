FROM ubuntu:xenial
MAINTAINER mail@thackbarth.net

ARG FACTORIO_VERSION=0.15.31
ARG CONTAINER_UID=2000
ARG CONTAINER_GID=2000

ENV DEBIAN_FRONTEND noninteractive

COPY entrypoint.sh /

RUN export CONTAINER_USER=gaming && \
    export CONTAINER_GROUP=gaming && \
    addgroup -gid $CONTAINER_GID $CONTAINER_GROUP && \
    adduser --system --home /home/$CONTAINER_USER --shell /bin/bash --uid $CONTAINER_UID --ingroup $CONTAINER_GROUP $CONTAINER_USER && \
    mkdir -p /factorio && \
    apt-get update && \
    apt-get install -y pwgen curl xz-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    curl -sSL https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 -o /tmp/factorio_headless_x64_${FACTORIO_VERSION}.tar.xz && \
    tar -xf /tmp/factorio_headless_x64_${FACTORIO_VERSION}.tar.xz --directory /opt && \
    rm /tmp/factorio_headless_x64_${FACTORIO_VERSION}.tar.xz && \
    chown -R gaming:gaming /opt/factorio && \
    chown -R gaming:gaming /factorio && \
    ln -s /factorio/saves /opt/factorio/saves && \
    ln -s /factorio/mods /opt/factorio/mods && \
    chmod 755 /entrypoint.sh

USER gaming

VOLUME ["/factorio"]
EXPOSE 34197/udp 27015/tcp

CMD ["/entrypoint.sh"]
