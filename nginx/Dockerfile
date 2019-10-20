FROM nginx:1.17.4-alpine
WORKDIR /root
USER root:root

RUN apk update \
	&& apk add --no-cache \
	bash \
	vim \
	curl \
	openssl

COPY --chown=root:root config/bashrc /root/.bashrc
COPY --chown=root:root gen_cert.sh /etc/ssl/certs

RUN cd /etc/ssl/certs && bash gen_cert.sh

CMD nginx -g "daemon off;"
