FROM php:8-apache

# Install the codebase from its GitHub release.
ARG OHMS_VIEWER_VERSION=v3.10.16
ENV OHMS_VIEWER_SOURCE_URL=https://github.com/uklibraries/ohms-viewer/archive/refs/tags/${OHMS_VIEWER_VERSION}.tar.gz
RUN curl -L $OHMS_VIEWER_SOURCE_URL | tar zx --strip-components=1

# Install useful tooling
RUN apt-get update -qq && \
    apt-get install -y rsync

# Bake program data (cachefiles) and config customizations directly into the image.
# These don't change very often so it's not really worth configuring them as volumes
# or configs.
COPY html /opt/app/ohms-customizations
RUN rsync -chavzP /opt/app/ohms-customizations/ /var/www/html/ && \
    rm -f /var/www/html/.htaccess

# The codebase throws a bunch of PHP8 warnings which, if not suppressed, clog up the
# rendered page. We suppress them by adding a custom configuration file per the base
# image docs.
COPY php/php.ini $PHP_INI_DIR/conf.d/

# Enable necessary apache mods
RUN a2enmod rewrite
