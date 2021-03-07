FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN $(which pip3) install -r requirements.txt

COPY . .

ENTRYPOINT [ "/usr/local/bin/curator" ]
