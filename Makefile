DOCKER_COMPOSE := $(shell which docker-compose)

.PHONY: list
list:
	date ; ${DOCKER_COMPOSE} -h
	date ; ${DOCKER_COMPOSE} ps

up:
	date ; ${DOCKER_COMPOSE} up -d

down:
	date ; ${DOCKER_COMPOSE} down

.PHONY: restart
restart: list down up

.PHONY: build test
build: list
	date ; ${DOCKER_COMPOSE} down --rmi all
	date ; ${DOCKER_COMPOSE} up -d

.PHONY: poc
poc:
	echo "curl --tlsv1.2 -vskL poc-proxy.example.com/uri/_info | jq ."
	date ; ${DOCKER_COMPOSE} exec poc bash

.PHONY: offload
offload:
	date ; ${DOCKER_COMPOSE} exec offload bash

.PHONY: reload
reload:
	date ; ${DOCKER_COMPOSE} exec offload nginx -t
	date ; ${DOCKER_COMPOSE} exec offload nginx -s reload

.PHONY: web01
web01:
	date ; ${DOCKER_COMPOSE} exec webapp001 bash

.PHONY: test
test:
	date ; ${DOCKER_COMPOSE} exec poc curl --tlsv1.2 -vskL poc-proxy.example.com/uri/
