FROM composer as builder
WORKDIR /app/
COPY composer.* ./
RUN composer install

FROM php:apache-bookworm
RUN apt-get update && apt-get install  -y libfile-mimeinfo-perl libmail-imapclient-perl libmime-tools-perl libxml-simple-perl libio-socket-inet6-perl libio-socket-ip-perl libperlio-gzip-perl libmail-mbox-messageparser-perl unzip libdbd-mysql-perl
COPY --from=builder /app/vendor /var/www/vendor
RUN docker-php-ext-install pdo pdo_mysql 
COPY parser /opt/parser
COPY code/ /var/www/html/
EXPOSE 80