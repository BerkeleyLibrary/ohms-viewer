FROM php:7-apache

# Install the codebase from its GitHub release.
ARG OHMS_VIEWER_VERSION=3.8.10
ENV OHMS_VIEWER_SOURCE_URL=https://github.com/uklibraries/ohms-viewer/archive/refs/tags/${OHMS_VIEWER_VERSION}.tar.gz
RUN curl -L $OHMS_VIEWER_SOURCE_URL | tar zx --strip-components=1

# Install useful tooling
RUN apt-get update -qq && \
    apt-get install -y rsync

# Bake program data (cachefiles) and config customizations directly into the image.
# These don't change very often so it's not really worth configuring them as volumes
# or configs.
COPY html /opt/app/ohms-customizations
RUN rsync -chavzP /opt/app/ohms-customizations/ /var/www/html/
