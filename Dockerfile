FROM debian:bullseye-slim as builder

RUN set -exu && dpkg --add-architecture i386 \
  && apt-get update -y \
  && apt-get install -y libcurl3-gnutls:i386 zlib1g:i386 lib32gcc-s1

FROM steamcmd/steamcmd:alpine

ARG DST_HOME=/app
ENV DST_INSTALL_PATH /opt/dst_server
ENV DST_USER_ROOT_PATH /app

COPY --from=builder /usr/lib/i386-linux-gnu /lib/
COPY --from=builder /usr/lib32 /lib/
COPY docker_entrypoint.sh /usr/local/bin/docker_entrypoint

RUN set -eux \
  && mkdir $DST_INSTALL_PATH $DST_HOME && chmod +x /usr/local/bin/docker_entrypoint

WORKDIR $DST_HOME

EXPOSE 10999-11000/udp 12346-12347/udp

ENTRYPOINT ["docker_entrypoint"]
