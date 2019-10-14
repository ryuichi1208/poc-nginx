FROM python:3.7

RUN mkdir /var/www
WORKDIR /var/www
COPY requirements.txt ./
COPY uwsgi.ini ./
RUN pip install -U pip
RUN pip install --no-cache-dir -r requirements.txt

CMD ["uwsgi", "--ini", "uwsgi.ini"]
