DOCKER_COMPOSE := $(shell which docker-compose)

pass:
	:

.PHONY: list
list:
	date ; ${DOCKER_COMPOSE} ps

up:
	date ; ${DOCKER_COMPOSE} up -d

down:
	date ; ${DOCKER_COMPOSE} down

.PHONY: build
build: list
	date ; ${DOCKER_COMPOSE} down --rmi all
	date ; ${DOCKER_COMPOSE} up -d

.PHONY: restart
restart: list down up

.PHONY: pocs
pocs:
	date ; ${DOCKER_COMPOSE} exec poc bash

.PHONY: proxy
proxy:
	date ; ${DOCKER_COMPOSE} exec nginx001 bash

.PHONY: reload
reload:
	date ; ${DOCKER_COMPOSE} exec nginx001 nginx -t
	date ; ${DOCKER_COMPOSE} exec nginx001 nginx -s reload

.PHONY: web01
web01:
	date ; ${DOCKER_COMPOSE} exec webapp001 bash
