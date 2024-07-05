#!/bin/bash

# Nome do projeto
PROJECT_NAME=$(basename "$PWD")

# Criação da estrutura de diretórios
mkdir -p app/models
mkdir -p app/views
mkdir -p app/controllers
mkdir -p app/utils
mkdir -p tests
mkdir -p docs

# Criação de arquivos __init__.py
touch app/__init__.py
touch app/models/__init__.py
touch app/views/__init__.py
touch app/controllers/__init__.py
touch app/utils/__init__.py
touch tests/__init__.py

# Função para criar arquivos com conteúdo
create_file() {
  local file_path=$1
  local content=$2
  echo "$content" > "$file_path"
}

# Criação de arquivos Python
create_file "README.md" '# Projeto de Relatório Automatizado de Empresas

Este projeto gera relatórios automatizados de empresas com base no ticker enviado pelo usuário. Inclui dados OHLCV (Open, High, Low, Close, Volume) e análise de sentimento de notícias utilizando a API da OpenAI.

## Estrutura do Projeto
project_root/
│
├── main.py
├── Dockerfile
├── docker-compose.yml
├── pyproject.toml
├── poetry.lock
├── .gitignore
├── README.md
├── app/
│ ├── init.py
│ ├── models/
│ │ ├── init.py
│ │ ├── ohlcv_model.py
│ │ └── news_model.py
│ ├── views/
│ │ ├── init.py
│ │ └── report_view.py
│ ├── controllers/
│ │ ├── init.py
│ │ ├── data_controller.py
│ │ └── sentiment_controller.py
│ └── utils/
│ ├── init.py
│ ├── data_fetcher.py
│ └── report_generator.py
├── tests/
│ ├── init.py
│ ├── test_models.py
│ ├── test_views.py
│ ├── test_controllers.py
│ └── test_utils.py
└── docs/
└── index.md


## Pré-requisitos

- [Python 3.9+](https://www.python.org/downloads/)
- [Poetry](https://python-poetry.org/docs/#installation)
- [Docker](https://www.docker.com/products/docker-desktop)
- [Git](https://git-scm.com/)

## Configuração do Ambiente

### 1. Clonar o Repositório

Clone o repositório do projeto para o seu ambiente local:

```bash
git clone <URL_do_repositório>
cd project_root
```
### 2. Inicializar o Poetry e Instalar Dependências
Inicialize o ambiente Poetry e instale as dependências do projeto:
```bash
poetry install
```

### 3. Configurar as Variáveis de Ambiente
Crie um arquivo .env na raiz do projeto e adicione suas chaves de API e outras variáveis necessárias:

```bash
OPENAI_API_KEY=your_openai_api_key
NEWS_API_KEY=your_news_api_key
DATABASE_URL=postgresql://user:password@db:5432/mydatabase
```

### 4. Executar o Docker Compose
Suba os serviços definidos no docker-compose.yml:

```bash
docker-compose up -d
```

### 5. Executar o Projeto
Com o ambiente configurado, você pode executar o projeto:

```bash
poetry run python main.py
```

## Testes
Para executar os testes, utilize o pytest:

```bash
poetry run pytest
```

## Estrutura do Código
. main.py: Ponto de entrada principal do projeto.
. app/models: Contém os modelos de dados.
. app/views: Contém as visualizações e a lógica de geração de relatórios.
. app/controllers: Contém a lógica de controle e manipulação de dados.
. app/utils: Contém utilitários para coleta e processamento de dados.
. tests: Contém os testes para as diferentes partes do projeto.
. docs: Contém a documentação do projeto.

##Contribuição
Para contribuir com este projeto, siga os passos abaixo:

1. Faça um fork do projeto.
2. Crie uma branch para sua feature (git checkout -b feature/nova-feature).
3. Commit suas alterações (git commit -m 'Adiciona nova feature').
4. Faça um push para a branch (git push origin feature/nova-feature).
5. Abra um Pull Request.
'


create_file "main.py" 'from app.controllers.data_controller import DataController
from app.controllers.sentiment_controller import SentimentController
from app.views.report_view import ReportView
from loguru import logger

def main(ticker):
    try:
        data_controller = DataController()
        sentiment_controller = SentimentController()
        report_view = ReportView()

        ohlcv_data = data_controller.get_ohlcv_data(ticker)
        news_data = data_controller.get_news_data(ticker)
        sentiments = sentiment_controller.analyze_sentiment(news_data)

        report = report_view.generate_report(ticker, ohlcv_data, sentiments)
        print(report)
    except Exception as e:
        logger.error(f"An error occurred: {e}")
        # Add your notification logic here (e.g., email, Telegram, Slack)

if __name__ == "__main__":
    ticker = "AAPL"  # Example ticker
    main(ticker)
'

create_file "app/models/ohlcv_model.py" 'class OHLCV:
    def __init__(self, open, high, low, close, volume):
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
'

create_file "app/models/news_model.py" 'class NewsArticle:
    def __init__(self, title, description, url, sentiment):
        self.title = title
        self.description = description
        self.url = url
        self.sentiment = sentiment
'

create_file "app/views/report_view.py" 'class ReportView:
    def generate_report(self, ticker, ohlcv_data, sentiments):
        report = f"Report for {ticker}\n\n"
        report += "OHLCV Data:\n"
        for data in ohlcv_data:
            report += f"{data}\n"
        report += "\nSentiments:\n"
        for sentiment in sentiments:
            report += f"{sentiment}\n"
        return report
'

create_file "app/controllers/data_controller.py" 'from app.utils.data_fetcher import DataFetcher

class DataController:
    def __init__(self):
        self.data_fetcher = DataFetcher()

    def get_ohlcv_data(self, ticker):
        return self.data_fetcher.fetch_ohlcv(ticker)

    def get_news_data(self, ticker):
        return self.data_fetcher.fetch_news(ticker)
'

create_file "app/controllers/sentiment_controller.py" 'from app.utils.report_generator import ReportGenerator

class SentimentController:
    def __init__(self):
        self.report_generator = ReportGenerator()

    def analyze_sentiment(self, news):
        return self.report_generator.analyze_sentiment(news)
'

create_file "app/utils/data_fetcher.py" 'import yfinance as yf
import requests

class DataFetcher:
    def fetch_ohlcv(self, ticker):
        stock = yf.Ticker(ticker)
        hist = stock.history(period="1wk")
        ohlcv_data = []
        for index, row in hist.iterrows():
            ohlcv_data.append({
                "Date": index,
                "Open": row["Open"],
                "High": row["High"],
                "Low": row["Low"],
                "Close": row["Close"],
                "Volume": row["Volume"]
            })
        return ohlcv_data

    def fetch_news(self, ticker):
        url = f"https://newsapi.org/v2/everything?q={ticker}&apiKey=YOUR_API_KEY"
        response = requests.get(url)
        news = response.json()["articles"]
        news_data = []
        for article in news:
            news_data.append({
                "title": article["title"],
                "description": article["description"],
                "url": article["url"]
            })
        return news_data
'

create_file "app/utils/report_generator.py" 'import openai

class ReportGenerator:
    def __init__(self):
        openai.api_key = "YOUR_API_KEY"

    def analyze_sentiment(self, news):
        sentiments = []
        for article in news:
            response = openai.Completion.create(
                model="text-davinci-003",
                prompt=f"Analyze the sentiment of this news article: {article["title"]}",
                max_tokens=50
            )
            sentiment = response.choices[0].text.strip()
            sentiments.append({
                "title": article["title"],
                "sentiment": sentiment
            })
        return sentiments
'

# Criação de arquivos de teste
create_file "tests/test_models.py" 'def test_ohlcv_model():
    from app.models.ohlcv_model import OHLCV
    ohlcv = OHLCV(100, 110, 90, 105, 1000)
    assert ohlcv.open == 100
    assert ohlcv.high == 110
    assert ohlcv.low == 90
    assert ohlcv.close == 105
    assert ohlcv.volume == 1000
'

create_file "tests/test_views.py" 'def test_report_view():
    from app.views.report_view import ReportView
    report_view = ReportView()
    report = report_view.generate_report("AAPL", [{"Date": "2021-01-01", "Open": 100, "High": 110, "Low": 90, "Close": 105, "Volume": 1000}], ["Positive"])
    assert "Report for AAPL" in report
    assert "OHLCV Data" in report
    assert "Sentiments" in report
'

create_file "tests/test_controllers.py" 'def test_data_controller():
    from app.controllers.data_controller import DataController
    data_controller = DataController()
    ohlcv_data = data_controller.get_ohlcv_data("AAPL")
    assert len(ohlcv_data) > 0

def test_sentiment_controller():
    from app.controllers.sentiment_controller import SentimentController
    sentiment_controller = SentimentController()
    sentiments = sentiment_controller.analyze_sentiment([{"title": "Apple hits new high"}])
    assert len(sentiments) > 0
'

create_file "tests/test_utils.py" 'def test_data_fetcher():
    from app.utils.data_fetcher import DataFetcher
    data_fetcher = DataFetcher()
    ohlcv_data = data_fetcher.fetch_ohlcv("AAPL")
    assert len(ohlcv_data) > 0

def test_report_generator():
    from app.utils.report_generator import ReportGenerator
    report_generator = ReportGenerator()
    sentiments = report_generator.analyze_sentiment([{"title": "Apple hits new high"}])
    assert len(sentiments) > 0
'

# Criação da documentação inicial
create_file "docs/index.md" '# Documentação do Projeto

Este projeto é um relatório automatizado de empresas baseado no ticker enviado pelo usuário. Ele inclui a análise de sentimentos de notícias utilizando dados de OHLCV e a API da OpenAI.
'

# Criação do Dockerfile
create_file "Dockerfile" 'FROM python:3.9-slim

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN pip install --no-cache-dir poetry \\
    && poetry config virtualenvs.create false \\
    && poetry install --no-interaction --no-ansi

COPY . .

CMD ["python", "main.py"]
'

# Criação do Docker Compose
create_file "docker-compose.yml" 'version: "3.8"

services:
  app:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/mydatabase
  db:
    image: postgres:13
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydatabase
    ports:
      - "5432:5432"
'

# Criação do .gitignore
create_file ".gitignore" '# Created by https://www.toptal.com/developers/gitignore/api/python
# Edit at https://www.toptal.com/developers/gitignore?templates=python

### Python ###
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
cover/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
.pybuilder/
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
#   For a library or package, you might want to ignore these files since the code is
#   intended to run in multiple environments; otherwise, check them in:
# .python-version

# pipenv
#   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
#   However, in case of collaboration, if having platform-specific dependencies or dependencies
#   having no cross-platform support, pipenv may install dependencies that dont work, or not
#   install all needed dependencies.
#Pipfile.lock

# poetry
#   Similar to Pipfile.lock, it is generally recommended to include poetry.lock in version control.
#   This is especially recommended for binary packages to ensure reproducibility, and is more
#   commonly ignored for libraries.
#   https://python-poetry.org/docs/basic-usage/#commit-your-poetrylock-file-to-version-control
#poetry.lock

# pdm
#   Similar to Pipfile.lock, it is generally recommended to include pdm.lock in version control.
#pdm.lock
#   pdm stores project-wide configurations in .pdm.toml, but it is recommended to not include it
#   in version control.
#   https://pdm.fming.dev/#use-with-ide
.pdm.toml

# PEP 582; used by e.g. github.com/David-OConnor/pyflow and github.com/pdm-project/pdm
__pypackages__/

# Celery stuff
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# pytype static type analyzer
.pytype/

# Cython debug symbols
cython_debug/

# PyCharm
#  JetBrains specific template is maintained in a separate JetBrains.gitignore that can
#  be found at https://github.com/github/gitignore/blob/main/Global/JetBrains.gitignore
#  and can be added to the global gitignore or merged into this file.  For a more nuclear
#  option (not recommended) you can uncomment the following to ignore the entire idea folder.
#.idea/

### Python Patch ###
# Poetry local configuration file - https://python-poetry.org/docs/configuration/#local-configuration
poetry.toml

# ruff
.ruff_cache/

# LSP config files
pyrightconfig.json

# End of https://www.toptal.com/developers/gitignore/api/python
'

# Criação do arquivo .env
create_file ".env" 'OPENAI_API_KEY=your_openai_api_key
NEWS_API_KEY=your_news_api_key
DATABASE_URL=postgresql://user:password@db:5432/mydatabase
'
# Inicialização do Poetry e instalação das dependências
poetry init -n
poetry add pandas yfinance requests openai loguru pytest SQLAlchemy duckdb fastparquet

# Inicialização do repositório Git
git init
git add .
git add setup_project.sh
git commit -m "Initial commit"

echo "Projeto configurado com sucesso!"
