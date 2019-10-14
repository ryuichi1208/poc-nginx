FROM alpine:3.10.2
WORKDIR /root
USER root:root

RUN apk update \
	&& apk add --no-cache \
	bash \
	vim \
	curl

COPY --chown=root:root config/bashrc /root/.bashrc
CMD ["bash"]
