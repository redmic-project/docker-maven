ARG MAVEN_IMAGE_TAG=3.8.4-openjdk-8-slim
FROM maven:${MAVEN_IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ARG GDAL_BIN_VERSION=2.4.0+dfsg-1+b1 \
	LIBXML2_UTILS_VERSION=2.9.10+dfsg-6.7 \
	DOCKER_VERSION=20.10.11 \
	DIRPATH=/opt/redmic \
	MAVEN_OPTS="-Duser.country=ES -Duser.language=es"

ENV MAVEN_OPTS=${MAVEN_OPTS}

RUN apt-get update && apt-get install -y --no-install-recommends \
		gdal-bin="${GDAL_BIN_VERSION}" \
		libxml2-utils="${LIBXML2_UTILS_VERSION}" && \
	rm -rf /var/lib/apt/lists/* && \
	curl -s -o /tmp/docker.tgz \
		"https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" && \
	tar -xf /tmp/docker.tgz --directory /tmp/ && \
	mv /tmp/docker/docker /usr/local/bin && \
	rm -rf docker.tgz /tmp/docker

COPY config/settings.xml /root/.m2/

WORKDIR ${DIRPATH}
