FROM debian:bullseye

RUN apt-get update -y --fix-missing
RUN apt-get install -y --fix-missing wget curl php-fpm php-mysql php-redis mariadb-client
RUN rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp

RUN mkdir -p /run/php

WORKDIR /var/www/html

COPY ./tools/wordpress-download.sh /usr/local/bin/wordpress-download.sh
RUN chmod +x /usr/local/bin/wordpress-download.sh && /usr/local/bin/wordpress-download.sh

COPY ./tools/wordpress-setup.sh /usr/local/bin/wordpress-setup.sh
RUN chmod +x /usr/local/bin/wordpress-setup.sh

EXPOSE 9000

CMD [ "bash", "/usr/local/bin/wordpress-setup.sh" ]