FROM steamcmd/steamcmd:alpine

ARG user steam
ARG home /app
ENV DST_INSTALL_PATH /opt/dst_server
ENV DST_USER_ROOT_PATH /app

RUN addgroup -S steam \
		&& adduser \
			--disabled-password \
			--gecos "" \
			--home $home \
			--ingroup steam \
			$user \
		&& mkdir $DST_INSTALL_PATH $home \
		&& chown -R steam:steam $home \
		&& chown -R steam:steam $DST_INSTALL_PATH

COPY docker_entrypoint.sh /usr/local/bin/docker_entrypoint

USER steam

EXPOSE 10999-11000/udp 12346-12347/udp

ENTRYPOINT ["docker_entrypoint"]
