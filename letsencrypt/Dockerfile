FROM ubuntu:zesty
MAINTAINER mail@thackbarth.net

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /etc/letsencrypt && \
    mkdir -p /var/www && \
    apt-get update && \
    apt-get install -y python python-virtualenv virtualenv git python-dev dialog gcc libssl-dev libffi-dev libaugeas0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    git clone https://github.com/letsencrypt/letsencrypt

VOLUME ["/etc/letsencrypt", "/var/www"]

ENTRYPOINT ["/letsencrypt/letsencrypt-auto"]
CMD ["--help"]
