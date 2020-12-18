ARG MAVEN_VERSION=3.5.3-jdk-8
FROM maven:${MAVEN_VERSION}

LABEL maintainer="info@redmic.es"

ARG GDAL_BIN_VERSION=2.1.2+dfsg-5 \
	LOCALES_VERSION=2.24-11+deb9u4 \
	LIBXML2_UTILS_VERSION=2.9.4+dfsg1-2.2+deb9u3

RUN apt-get update && apt-get install -y --no-install-recommends \
		gdal-bin=${GDAL_BIN_VERSION} \
		locales=${LOCALES_VERSION} \
		libxml2-utils=${LIBXML2_UTILS_VERSION} && \
	rm -rf /var/lib/apt/lists/*

ARG LANG=es_ES.UTF-8

RUN sed -i -e 's/# ${LANG} UTF-8/${LANG} UTF-8/' /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=${LANG}

ENV LANG=${LANG}

ARG DOCKER_VERSION=19.03.11

RUN wget -q -P /tmp/ https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
	tar -xf /tmp/docker-${DOCKER_VERSION}.tgz --directory /tmp/ && \
	mv /tmp/docker/docker /usr/local/bin && \
	rm -rf docker-${DOCKER_VERSION}.tgz /tmp/docker

COPY config/settings.xml /root/.m2/

ARG DIRPATH=/opt/redmic

WORKDIR ${DIRPATH}
