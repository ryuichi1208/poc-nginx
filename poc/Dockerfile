FROM alpine:3.10.2
WORKDIR /root
USER root:root

# RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump
COPY --chown=root:root config/bashrc /root/.bashrc
COPY --chown=root:root tools/http.c /root
COPY --chown=root:root tools/tcp_client.py /root
COPY --chown=root:root tools/tcp_srv.py /root

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
	python3 \
	libc-dev

CMD ["bash"]
