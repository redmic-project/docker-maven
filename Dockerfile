FROM maven:3.5.3-jdk-8

LABEL maintainer="info@redmic.es"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    gdal-bin \
    locales \
    libxml2-utils && \
  rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale LANG=es_ES.UTF-8

ARG DOCKER_VERSION="docker-19.03.14"

RUN wget -P /tmp/ https://download.docker.com/linux/static/stable/x86_64/${DOCKER_VERSION}.tgz && \
  tar -xvf /tmp/${DOCKER_VERSION}.tgz --directory /tmp/ && \
  mv /tmp/docker/docker /usr/local/bin

ENV DIRPATH="/opt/redmic" \
  LANG="es_ES.UTF-8"

RUN mkdir ${DIRPATH}

COPY config/settings.xml /root/.m2/

WORKDIR ${DIRPATH}
