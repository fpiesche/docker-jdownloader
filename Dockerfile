# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie@sha256:7fa5ffec83a1dbe5397d5751b9e072f8abe5c74b5e2f1f6d2442ab08fcd76970

# title
ENV TITLE="JDownloader 2" \
    PIXELFLUX_WAYLAND=true

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://cdn.jsdelivr.net/gh/selfhst/icons@main/png/jdownloader.png

RUN \
  echo "**** install packages ****" && \
  mkdir -p /usr/share/man/man1 && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    default-jre && \
  curl -o /defaults/JDownloader.jar https://installer.jdownloader.org/JDownloader.jar

RUN \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /usr/share/man \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# Selkies
EXPOSE 3001
# JDownloader for myJDownloader in direct connection mode
EXPOSE 3129

VOLUME /config
VOLUME /output

# Metadata.
LABEL \
  org.label-schema.name="jdownloader" \
  org.label-schema.description="Docker container for JDownloader using Selkies" \
  org.label-schema.vcs-url="https://github.com/fpiesche/docker-jdownloader" \
  org.label-schema.schema-version="1.0"
