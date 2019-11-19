FROM centos:centos8
LABEL author="ryuichi1208 <ryucrosskey@gmail.com>"
LABEL com.example.version="0.0.1-beta"

USER root:root
WORKDIR /home/app001

ARG STUFFED_VERSION="1.0.0"
ARG STUFFED_ENABLE_ALL=""

# yum
RUN dnf -y update \
	&& dnf upgrade \
	&& dnf install -y \
	glibc-common \
	bash-completion \
	epel-release \
        && dnf clean all

ENV LANG ja_JP.UTF-8 \
	LANGUAGE ja_JP:ja \
	LC_ALL ja_JP.UTF-8 \
	TZ Asia/Tokyo

# dotfiles
COPY --chown=root:root dotfiles/vimrc.txt /root/.vimrc
COPY --chown=root:root dotfiles/zshrc.txt /root/.zshrcopt.zsh
COPY --chown=root:root dotfiles/prezto.sh /root/prezto.sh

# RUN apk --update add ruby && rm -rf /var/cache/apk/*
RUN dnf install -y \
	cmake \
	curl \
	dstat \
	jq \
	gdb \
	git \
	golang \
	htop \
	lsof \
	make \
	net-tools \
	nodejs \
	python3 \
	redis \
	vim \
	zsh

# zsh/fzf
RUN dnf clean all \
	&& git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf \
        && /root/.fzf/install \
	&& git clone --recursive https://github.com/sorin-ionescu/prezto.git /root/.zprezto \
	&& rm -f /root/.zshrc \
	&& zsh /root/prezto.sh \
	&& echo "zstyle ':prezto:module:prompt' theme 'paradox'" >> /root/.zpreztorc \
	&& echo "source /root/.zshrcopt.zsh" >> /root/.zshrc \
	&& curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh \
        && mkdir -p ~/.cache/dein \
	&& sh ./installer.sh /root/.cache/dein \
	&& npm install markdown-it --save
	# && ./configure \
	#       --with-http_ssl_module \
              # --with-http_gzip_static_module \
              # --prefix=/usr/share/nginx \
              # --sbin-path=/usr/local/sbin/nginx \
              # --conf-path=/etc/nginx/conf/nginx.conf \
              # --pid-path=/var/run/nginx.pid \
              # --http-log-path=/var/log/nginx/access.log \
              # --error-log-path=/var/log/nginx/error.log \

# python
COPY --chown=root:root requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
ENV PYTHONUNBUFFERED 1

# golang
RUN go get -u github.com/labstack/echo \
	&& go get -v golang.org/x/tools/cmd/goimports
ENV CGO_ENABLED 0 \
	GOOS linux

# HEALTHCHECK --interval=5m --timeout=3s \
  # CMD curl -f http://localhost/ || exit 1

SHELL ["/bin/zsh"]
ENTRYPOINT ["/bin/zsh"]
