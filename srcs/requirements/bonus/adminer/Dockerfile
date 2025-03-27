FROM debian:bullseye

RUN apt-get update -y --fix-missing
RUN apt-get install -y --fix-missing wget php php-mysql
RUN rm -rf /var/lib/apt/lists/*

COPY ./tools/setup.sh /usr/local/bin/setup.sh

EXPOSE 8080

CMD [ "bash", "/usr/local/bin/setup.sh" ]