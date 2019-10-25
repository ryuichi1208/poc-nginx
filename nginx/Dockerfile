FROM nginx:1.17.4-alpine
WORKDIR /root
USER root:root
ENV DOCKER_GEN_VERSION 0.7.4

RUN apk update \
	&& apk add --no-cache \
	bash \
	vim \
	curl \
	openssl \
	&& mkdir -p /var/cache/nginx/proxy_temp/domain

COPY --chown=root:root config/bashrc /root/.bashrc
COPY --chown=root:root gen_cert.sh /etc/ssl/certs

# RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 # && sed -i 's/worker_processes  1/worker_processes  auto/' /etc/nginx/nginx.conf

RUN cd /etc/ssl/certs && bash gen_cert.sh

CMD nginx -g "daemon off;"
