FROM alpine:3.10.2
WORKDIR /root
USER root:root

RUN set -ex \
        && apk update \
	&& apk upgrade \
	&& apk add --no-cache \
	apache2-utils \
	bash \
	busybox \
	busybox-extras \
	curl \
	ethtool \
	jq \
	ltrace \
	ngrep \
	socat \
	strace \
	tcpdump \
	vim

# RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump
COPY --chown=root:root config/bashrc /root/.bashrc
CMD ["bash"]
