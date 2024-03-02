FROM python:3.8.16

WORKDIR /api

RUN pip install poetry
COPY pyproject.toml poetry.lock* /api/

# --no-rootオプションでプロジェクト自体はインストールしない
RUN poetry config virtualenvs.create false \
  && poetry install --no-dev --no-interaction --no-ansi

COPY . /api

CMD poetry run uvicorn main:app --host 0.0.0.0 --port $PORT

