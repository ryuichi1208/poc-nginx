FROM nginx:1.17.4-alpine
WORKDIR /root
USER root:root

RUN apk update \
	&& apk add --no-cache \
	bash \
	vim \
	curl

COPY --chown=root:root config/bashrc /root/.bashrc

CMD nginx -g "daemon off;"
