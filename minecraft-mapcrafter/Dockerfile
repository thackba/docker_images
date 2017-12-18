FROM ubuntu:zesty
MAINTAINER mail@thackbarth.net

ENV DEBIAN_FRONTEND noninteractive
ENV MINECRAFT_VERSION 1.12
ENV MINECRAFT_VERSION_MANIFEST https://launchermeta.mojang.com/mc/game/version_manifest.json

COPY get_current_client.py /

RUN mkdir -p /data/input && \
    mkdir -p /data/output && \
    apt-get update && \
    apt-get install -y libpng-dev libjpeg-dev libboost-iostreams-dev libboost-system-dev libboost-filesystem-dev \
                       libboost-program-options-dev build-essential cmake git curl python imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    git clone https://github.com/mapcrafter/mapcrafter.git && \
    python /get_current_client.py

WORKDIR /mapcrafter

RUN cmake . && \
    make && \
    make install && \
    ldconfig && \
    mapcrafter_textures.py /minecraft_client.jar /usr/local/share/mapcrafter/textures

VOLUME ["/data/input", "/data/output"]

ENTRYPOINT ["mapcrafter"]
CMD ["--help"]
