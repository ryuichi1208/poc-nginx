[![CircleCI](https://img.shields.io/circleci/build/github/ryuichi1208/poc-nginx/master)](https://circleci.com/gh/ryuichi1208/poc-nginx)
![size](https://img.shields.io/github/languages/code-size/ryuichi1208/poc-nginx)

# poc-nginx
docker-compose network for nginx verification.

## Description

A repository for building a simple reverse proxy verification environment using Nginx.

## Features

* Nginx conf syntax test.
* Reverse proxy using Nginx.
* Validation for HTTP Request/Response header.
* SSL offload validation.
* Survey on various types of cash.

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
```

## License

Apache License

## Author

[ryuichi1208](https://github.com/ryuichi1208)
