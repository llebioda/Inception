FROM debian:bullseye

RUN apt-get update -y --fix-missing
RUN apt-get install -y --fix-missing redis-server
RUN rm -rf /var/lib/apt/lists/*

RUN sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g" /etc/redis/redis.conf
RUN echo -e "maxmemory 256mb\nmaxmemory-policy allkeys-lru\n" >> /etc/redis/redis.conf
RUN echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf

EXPOSE 6379

CMD [ "redis-server", "--protected-mode", "no" ]