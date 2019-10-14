FROM python:3.7

RUN mkdir /var/www
WORKDIR /var/www
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "main.py"]
