FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

RUN mkdir /app

WORKDIR /app

RUN apk update \
    && apk add --update --no-cache postgresql-client jpeg-dev \
    && apk add --update --no-cache --virtual .tmp-build-deps gcc libc-dev linux-headers musl-dev postgresql-dev musl-dev zlib zlib-dev libjpeg

RUN pip3 install --upgrade pip
RUN pip3 install pipenv

COPY Pipfile ./Pipfile
COPY Pipfile.lock ./Pipfile.lock

RUN pipenv install --deploy --ignore-pipfile

# Required for installing Pip dependencies
RUN apk del .tmp-build-deps

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

COPY . ./app
