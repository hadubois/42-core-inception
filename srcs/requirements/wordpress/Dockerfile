FROM debian:bullseye

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y php php-fpm php-mysql php-cli\
	wget tar

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/init.sh /
RUN chmod +x /init.sh

ENTRYPOINT [ "sh", "./init.sh" ]