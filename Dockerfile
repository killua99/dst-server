FROM steamcmd/steamcmd:alpine

ARG DST_HOME=/app
ENV DST_INSTALL_PATH /opt/dst_server
ENV DST_USER_ROOT_PATH /app

RUN set -eux \
  && mkdir $DST_INSTALL_PATH $DST_HOME

COPY docker_entrypoint.sh /usr/local/bin/docker_entrypoint

RUN chmod +x /usr/local/bin/docker_entrypoint

WORKDIR $DST_HOME

EXPOSE 10999-11000/udp 12346-12347/udp

ENTRYPOINT ["docker_entrypoint"]
