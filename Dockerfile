FROM steamcmd/steamcmd:alpine

ARG user steam
ARG home /app
ENV DST_INSTALL_PATH /opt/dst_server
ENV DST_USER_ROOT_PATH /app

RUN set -eux \
  && addgroup -S steam \
  && mkdir $DST_INSTALL_PATH $home \
  && adduser \
    --disabled-password \
    --gecos "" \
    --home $home \
    --ingroup steam \
    $user \
  && chown -R $user:steam $home \
  && chown -R $user:steam $DST_INSTALL_PATH

COPY docker_entrypoint.sh /usr/local/bin/docker_entrypoint

RUN chmod +x /usr/local/bin/docker_entrypoint

WORKDIR $home
USER $user

EXPOSE 10999-11000/udp 12346-12347/udp

ENTRYPOINT ["docker_entrypoint"]
