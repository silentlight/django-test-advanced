FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

RUN mkdir /app

WORKDIR /app

RUN apk update \
    && apk add --update --no-cache postgresql-client \
    && apk add --update --no-cache --virtual .tmp-build-deps gcc libc-dev linux-headers musl-dev postgresql-dev

RUN pip3 install --upgrade pip
RUN pip3 install pipenv

COPY Pipfile ./Pipfile
COPY Pipfile.lock ./Pipfile.lock

RUN pipenv install --deploy --ignore-pipfile

RUN apk del .tmp-build-deps

COPY . ./app
