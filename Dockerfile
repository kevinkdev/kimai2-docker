FROM php:7.4-apache
MAINTAINER Kevin Kamani <kevinkdev97@gmail.com>
ENV USERNAME=
ENV PASSWORD=
ENV DB_NAME=
ENV DB_PORT=
ENV DB_HOST=
ARG DEBIAN_FRONTEND=noninteractive
ARG KIMAI="1.14"


RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip git zip \
    libpng-dev libicu-dev libzip-dev libxslt-dev sudo \
  && docker-php-ext-install intl \
  && docker-php-ext-install gd \
  && docker-php-ext-install zip \
  && docker-php-ext-install pdo \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install xsl \
  && rm -rf /var/lib/apt/lists/* \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --quiet \
  && rm composer-setup.php \
  && mv composer.phar /usr/local/bin/composer \
  && mkdir -p /var/www \
  && cd /var/www \
  && git clone -b ${KIMAI} --depth 1 https://github.com/kevinpapst/kimai2.git \
  && cd kimai2 \
  && chown -R www-data:www-data /var/www \
  && chown -R :www-data . \
  && chmod -R g+r . \
  && chmod -R g+rw var/ \
  && sudo -u www-data composer install --no-dev --optimize-autoloader \
  && cd /usr/local/etc/php \
  && ln -s php.ini-production php.ini

ENV APACHE_DOCUMENT_ROOT /var/www/kimai2/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


COPY .env /var/www/kimai2/.env
COPY kimai.conf /etc/apache2/sites-available/kimai.conf
RUN sed 's/USERNAME/${USERNAME}/' /var/www/kimai2/.env
RUN sed 's/PASSWORD/${PASSWORD}/' /var/www/kimai2/.env
RUN sed 's/DB_NAME/${DB_NAME}/' /var/www/kimai2/.env
RUN sed 's/DB_PORT/${DB_PORT}/' /var/www/kimai2/.env
RUN sed 's/HOST/${DB_HOST}/' /var/www/kimai2/.env
COPY local.yaml /var/www/kimai2/config/packages/local.yaml
RUN chown www-data:www-data /var/www/kimai2/.env
RUN chown www-data:www-data /var/www/kimai2/config/packages/local.yaml

COPY startup.sh /

RUN chmod 755 /startup.sh

CMD ["bash","/startup.sh"]
