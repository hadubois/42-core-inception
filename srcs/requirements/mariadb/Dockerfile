FROM	debian:bullseye

RUN	apt-get update \
	&& apt-get -y upgrade \
	&& apt-get -y install mariadb-server


COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/init.sh /tmp/init.sh
RUN	chmod +x /tmp/init.sh

ENTRYPOINT ["sh", "./tmp/init.sh"]