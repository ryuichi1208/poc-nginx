#############################
# docker settings           #
#############################
DOCKER := $(shell which docker)
DOCKER_COMPOSE := $(shell which docker-compose)

#############################
# test-tool build settings  #
#############################
INCDIR  := -I /usr/local/include -I /usr/include
CFLAGS  := -Wall -O2 $(INCDIR)
LDFLAGS := -L /usr/lib -L /usr/local/lib
CFLAGS  := -g -MMD -MP -Wall -Wextra -Winit-self -Wno-missing-field-initializers

.PHONY: list
list:
	date ; ${DOCKER_COMPOSE} -h
	date ; ${DOCKER_COMPOSE} ps

up:
	date ; ${DOCKER_COMPOSE} up -d

down:
	date ; ${DOCKER_COMPOSE} down

.PHONY: restart
restart: list down up update-cert

.PHONY: build
build: list
	date ; ${DOCKER_COMPOSE} down --rmi all
	date ; ${DOCKER_COMPOSE} up -d
	rm -f tmp/server*

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

.PHONY: update-cert
update-cert:
	date ; ${DOCKER} container cp nginx.dev.com:/etc/ssl/certs/server.crt tmp
	date ; ${DOCKER} container cp nginx.dev.com:/etc/ssl/certs/server_wild.crt tmp
	date ; ${DOCKER} container cp tmp/server.crt poc:/usr/local/share/ca-certificates
	date ; ${DOCKER} container cp tmp/server_wild.crt poc:/usr/local/share/ca-certificates
	date ; ${DOCKER_COMPOSE} exec poc update-ca-certificates
	# date ; ${DOCKER_COMPOSE} exec poc update-ca-trust

.PHONY: web01
web01:
	date ; ${DOCKER_COMPOSE} exec webapp001 bash

.PHONY: web02
web02:
	date ; ${DOCKER_COMPOSE} exec webapp002 bash

.PHONY: web03
web02:
	date ; ${DOCKER_COMPOSE} exec webapp002 bash

.PHONY: test
test:
	date ; ${DOCKER_COMPOSE} exec poc curl --tlsv1.2 -vskL poc-proxy.example.com/uri/
