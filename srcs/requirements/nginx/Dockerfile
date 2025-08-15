FROM debian:bullseye

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=hadubois.42.fr/UID=hadubois"

COPY ./conf/default /etc/nginx/sites-available/default

RUN chmod 755 /var/www/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]