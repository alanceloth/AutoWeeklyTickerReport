# Projeto de Relatório Automatizado de Empresas

Este projeto gera relatórios automatizados de empresas com base no ticker enviado pelo usuário. Inclui dados OHLCV (Open, High, Low, Close, Volume) e análise de sentimento de notícias utilizando a API da OpenAI.

## Estrutura do Projeto
```
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
```

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
3. Commit suas alterações (git commit -m Adiciona
