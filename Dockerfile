FROM php:7.4-apache
LABEL maintainer="Kevin Kamani <kevinkdev97@gmail.com>"
ENV USERNAME=
ENV PASSWORD=
ENV DB_NAME=
ENV DB_PORT=
ENV DB_HOST=
ARG DEBIAN_FRONTEND=noninteractive
ARG KIMAI="1.14.1"

RUN rm /etc/apache2/sites-enabled/000-default.conf

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

COPY .env /var/www/kimai2/.env
COPY kimai.conf /etc/apache2/sites-enabled/kimai.conf

COPY local.yaml /var/www/kimai2/config/packages/local.yaml
RUN chown www-data:www-data /var/www/kimai2/.env
RUN chown www-data:www-data /var/www/kimai2/config/packages/local.yaml

EXPOSE 80
COPY startup.sh /

RUN chmod 755 /startup.sh

CMD ["bash","/startup.sh"]
