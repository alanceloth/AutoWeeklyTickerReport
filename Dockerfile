FROM python:3.11-slim

# Definir diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    gcc \
    curl

# Instalar Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Adicionar Poetry ao PATH
ENV PATH="/root/.local/bin:$PATH"

# Copiar arquivos do Poetry
COPY pyproject.toml poetry.lock ./

# Instalar dependências do Poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Copiar todo o conteúdo do projeto
COPY . .

# Comando padrão
CMD ["python", "main.py"]
