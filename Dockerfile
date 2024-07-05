FROM python:3.9-slim

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN pip install --no-cache-dir poetry \\
    && poetry config virtualenvs.create false \\
    && poetry install --no-interaction --no-ansi

COPY . .

CMD ["python", "main.py"]

