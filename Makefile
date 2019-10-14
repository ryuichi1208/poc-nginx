DOCKER_COMPOSE := $(shell which docker-compose)

pass:
	:
build:
	${DOCKER_COMPOSE} down --rmi all
	${DOCKER_COMPOSE} up -d

restart:
	${DOCKER_COMPOSE} down
	${DOCKER_COMPOSE} up -d

poc:
	${DOCKER_COMPOSE} exec poc bash

nginx:
	${DOCKER_COMPOSE} exec nginx001 bash

web01:
	${DOCKER_COMPOSE} exec webapp001 bash
