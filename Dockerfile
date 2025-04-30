ARG BASE_IMAGE_TAG="21-jdk-alpine"
FROM eclipse-temurin:${BASE_IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ARG DIRPATH \
	MAVEN_OPTS="-Duser.country=ES -Duser.language=es"

ENV MAVEN_OPTS=${MAVEN_OPTS}

WORKDIR "${DIRPATH}"

COPY config/settings.xml /root/.m2/
