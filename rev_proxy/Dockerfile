FROM centos:centos7
WORKDIR /etc/
COPY ./nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum update -y \
	&& yum install -y \
	vim \
	nginx \
	curl \
	lsof \
	bash-completion
