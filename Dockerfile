FROM python:3.7

ENV PYTHONUNBUFFERED 1

RUN mkdir /app

WORKDIR /app

RUN pip install pipenv

COPY Pipfile ./Pipfile
COPY Pipfile.lock ./Pipfile.lock

RUN pipenv install --deploy --ignore-pipfile

COPY . ./app
