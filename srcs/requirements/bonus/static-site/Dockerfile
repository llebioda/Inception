FROM debian:bullseye

RUN apt-get update -y --fix-missing
RUN apt-get install -y --fix-missing apache2
RUN rm -rf /var/lib/apt/lists/*

COPY ./srcs/ /var/www/html/

EXPOSE 80

CMD [ "apachectl", "-D", "FOREGROUND" ]