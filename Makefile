DC=docker-compose
SRC=srcs/docker-compose.yml

up:
	$(DC) -f $(SRC) up -d

down:
	$(DC) -f $(SRC) down

build:
	$(DC) -f $(SRC) build --no-cache

logs:
	$(DC) $(SRC) logs -f

clean:
	-docker stop $$(docker ps -aq) ;
	-docker rm -f $$(docker ps -aq) ;
	-docker rmi -f $$(docker images -aq) ;
	-docker volume rm $$(docker volume ls -q) ;
	-docker network rm $$(docker network ls -q) 2>/dev/null;

.PHONY: up down build logs clean

