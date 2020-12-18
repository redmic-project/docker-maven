ARG MAVEN_VERSION=3.6.3-jdk-8-slim
FROM maven:${MAVEN_VERSION}

LABEL maintainer="info@redmic.es"

ARG GDAL_BIN_VERSION=2.4.0+dfsg-1+b1 \
	LOCALES_VERSION=2.28-10 \
	LIBXML2_UTILS_VERSION=2.9.4+dfsg1-7+deb10u1

RUN apt-get update && apt-get install -y --no-install-recommends \
		gdal-bin="${GDAL_BIN_VERSION}" \
		locales="${LOCALES_VERSION}" \
		libxml2-utils="${LIBXML2_UTILS_VERSION}" && \
	rm -rf /var/lib/apt/lists/*

ARG LANG=es_ES.UTF-8

RUN sed -i -e "s/# ${LANG} UTF-8/${LANG} UTF-8/" /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG="${LANG}"

ENV LANG=${LANG}

ARG DOCKER_VERSION=20.10.1

RUN curl -s -o /tmp/docker.tgz \
		"https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" && \
	tar -xf /tmp/docker.tgz --directory /tmp/ && \
	mv /tmp/docker/docker /usr/local/bin && \
	rm -rf docker.tgz /tmp/docker

COPY config/settings.xml /root/.m2/

ARG DIRPATH=/opt/redmic

WORKDIR ${DIRPATH}
