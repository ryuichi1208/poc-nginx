![release](https://img.shields.io/badge/release-v1.0.0-red)
![License](https://img.shields.io/github/license/ryuichi1208/poc-nginx)
![size](https://img.shields.io/github/languages/code-size/ryuichi1208/poc-nginx)
[![CircleCI](https://img.shields.io/circleci/build/github/ryuichi1208/poc-nginx/master)](https://circleci.com/gh/ryuichi1208/poc-nginx)

# poc-nginx

![logo](https://github.com/ryuichi1208/poc-nginx/blob/master/doc/images/logo.png)

docker-compose network for nginx verification.

## Description

A repository for building a simple reverse proxy verification environment using Nginx.

## Features

* Nginx conf syntax test.
* Reverse proxy using Nginx.
* Validation for HTTP Request/Response header.
* SSL offload validation.
* Survey on various types of cash.
* Packet flow at the tcp layer.

## Requirement

* Docker 18.09+
* docker-compose 1.24.1+

## Install & Usage

``` bash
# Install
$ git clone https://github.com/ryuichi1208/poc-nginx.git
$ cd poc-nginx

# Usage
$ make help

# packet capture
# cf. https://troushoo.blog.fc2.com/blog-entry-352.html
$ docker run –it –v ~/pcap:/pcap --net=host ubuntu
```

## License

Apache License

## Author

[ryuichi1208](https://github.com/ryuichi1208)
