FROM python:3.11-buster

ARG POETRY_VERSION="1.6.1"

WORKDIR /workspace
COPY pyproject.toml poetry.lock ./

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc git libgomp1 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -U pip setuptools wheel
RUN pip install --no-cache-dir poetry==${POETRY_VERSION}

RUN poetry config virtualenvs.create true \
    && poetry config virtualenvs.in-project true

RUN poetry install