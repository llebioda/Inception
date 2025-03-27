FROM debian:bullseye

RUN apt-get update -y --fix-missing
RUN apt-get install -y --fix-missing nginx openssl
RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/default /etc/nginx/sites-enabled/default

RUN mkdir /etc/nginx/ssl -p
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -keyout /etc/nginx/ssl/key.key \
       -out /etc/nginx/ssl/key.crt \
       -subj "/C=FR/L=Paris/O=42/OU=student/CN=llebioda.42.fr"

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
