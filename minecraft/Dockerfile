FROM thackba/java:latest
MAINTAINER mail@thackbarth.net

ARG CONTAINER_UID=1100
ARG CONTAINER_GID=1100

ENV DEBIAN_FRONTEND noninteractive
ENV MINECRAFT_VERSION=1.12.1
ENV MEMORY_MIN=1024
ENV MEMORY_MAX=1024

RUN export CONTAINER_USER=minecraft && \
    export CONTAINER_GROUP=minecraft && \
    addgroup -gid $CONTAINER_GID $CONTAINER_GROUP && \
    adduser --system --home /home/$CONTAINER_USER --shell /bin/bash --uid $CONTAINER_UID --ingroup $CONTAINER_GROUP $CONTAINER_USER && \
    mkdir -p /data && \
    chown -R $CONTAINER_UID:$CONTAINER_GID /data && \
    wget -q https://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/minecraft_server.${MINECRAFT_VERSION}.jar

WORKDIR /data

EXPOSE 25565
EXPOSE 25575

USER minecraft

VOLUME /data

CMD echo eula=true > /data/eula.txt && \
    java -Xms${MEMORY_MIN}M -Xmx${MEMORY_MAX}M -jar /minecraft_server.${MINECRAFT_VERSION}.jar nogui
