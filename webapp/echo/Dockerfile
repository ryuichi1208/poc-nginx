FROM golang:1.13-alpine3.10 as builder
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
USER root:root
WORKDIR /home/app
COPY main.go .
RUN apk update --no-cache && apk add -y gcc git --no-cache \
	&& go get -u github.com/labstack/echo \
	&& go build main.go

FROM alpine:3.10
RUN apk add --no-cache ca-certificates nginx \
	&& mkdir /run/nginx
WORKDIR /home/app
COPY --from=builder --chown=root:root /home/app/main /home/app
ENTRYPOINT ["nohup", "./main", "&" , ";" , "nginx", "-g", "daemon off'"]
