FROM python:3.7

RUN mkdir /var/www
WORKDIR /var/www

COPY --chown=root:root requirements.txt .
COPY --chown=root:root uwsgi.ini .

RUN apt update -y && apt upgrade -y \
	&& apt install -y tcpdump \
	&& pip install -U pip \
	&& pip install --no-cache-dir -r requirements.txt

CMD ["uwsgi", "--ini", "uwsgi.ini"]
