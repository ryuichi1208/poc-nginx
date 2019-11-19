FROM alpine:3.10.2
WORKDIR /root
USER root:root

# RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump
COPY --chown=root:root config/bashrc /root/.bashrc
COPY --chown=root:root http.c /root

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
	gcc \
	jq \
	ltrace \
	ngrep \
	socat \
	strace \
	tcpdump \
	vim \
	libc-dev \
	&& gcc -O2 -o http src tools/http.c

CMD ["bash"]
