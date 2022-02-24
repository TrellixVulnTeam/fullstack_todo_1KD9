FROM python:3.9
ENV PYTHONUNBUFFERED 1
#RUN set -e;
#RUN apk update

WORKDIR /code

#RUN apk add --no-cache postgresql-client libffi-dev gcc musl-dev zlib-dev
#RUN apk add --no-cache --virtual .build-deps linux-headers libc-dev postgresql-dev
#
RUN pip3 install poetry

ADD pyproject.toml poetry.lock ./
RUN pip install poetry && poetry config virtualenvs.create false
RUN poetry install
#RUN apk del .build-deps

COPY . /code/


#
#RUN pip3 install poetry
#ADD pyproject.toml poetry.lock ./
#RUN pip install poetry && poetry config virtualenvs.create false
#RUN poetry install
#COPY . /code/