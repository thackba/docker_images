FROM ubuntu:zesty
MAINTAINER mail@thackbarth.net

ARG CONTAINER_UID=1400
ARG CONTAINER_GID=1400

ENV DEBIAN_FRONTEND noninteractive

COPY entrypoint.sh /

RUN export CONTAINER_USER=steam && \
    export CONTAINER_GROUP=steam && \
    addgroup -gid $CONTAINER_GID $CONTAINER_GROUP && \
    adduser --system --home /home/$CONTAINER_USER --shell /bin/bash --uid $CONTAINER_UID --ingroup $CONTAINER_GROUP $CONTAINER_USER && \
    apt-get update && \
    apt-get install -y wget lib32stdc++6 lib32z1 lib32gcc1 xmlstarlet && \
    apt-get clean && \
    rm -rf /var/lib/apt/* /tmp/* /var/tmp/* /var/cache/apt/* && \
    mkdir -p /steamcmd && \
    wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz --directory /steamcmd && \
    rm steamcmd_linux.tar.gz && \
    chown -R steam:steam /steamcmd && \
    chmod 755 /steamcmd/*.sh && \
    mkdir -p /config && \
    chown -R steam:steam /config && \
    mkdir -p /server && \
    chown -R steam:steam /server && \
    chmod 755 /entrypoint.sh

EXPOSE 26900/tcp
EXPOSE 8082/tcp
VOLUME ["/server", "/home/steam"]

USER steam

CMD ["/entrypoint.sh", "7days"]