FROM python:3.8.1-alpine3.11
WORKDIR /app
COPY . /app
RUN apk update --no-cache \
    && pip install pipenv \
    && pipenv sync \
    && echo "echo 'exec command -> pipenv shell'" > ~/.profile
ENTRYPOINT [ "/bin/sh", "--login" ]
