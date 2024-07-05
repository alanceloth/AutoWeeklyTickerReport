import os
from dotenv import load_dotenv
from app.controllers.data_controller import DataController
from app.controllers.sentiment_controller import SentimentController
from app.views.report_view import ReportView
from loguru import logger

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()

# Configurar a chave da API do OpenAI
openai_api_key = os.getenv("OPENAI_API_KEY")
news_api_key = os.getenv("NEWS_API_KEY")

def main(ticker):
    try:
        data_controller = DataController(news_api_key)
        sentiment_controller = SentimentController(openai_api_key)
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
