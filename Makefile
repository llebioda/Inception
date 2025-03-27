COMPOSE_FILE = ./srcs/docker-compose.yml
USER = llebioda

all: up

up:
	mkdir -p /home/$(USER)/data/wordpress /home/$(USER)/data/maria-db /home/$(USER)/data/prometheus
	docker compose -f $(COMPOSE_FILE) up --build -d

down:
	docker compose -f $(COMPOSE_FILE) down

ps status:
	@ docker ps

clean:
	docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q) || true

re: down clean all

.PHONY: all up down ps status clean re

#delete all cache : docker system prune -a