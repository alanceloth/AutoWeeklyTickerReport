import os
from dotenv import load_dotenv
from app.controllers.data_controller import DataController
from app.controllers.sentiment_controller import SentimentController
from app.views.report_view import ReportView
from loguru import logger
from app.utils.create_tables import create_tables
from sqlalchemy import inspect
from app.models.ohlcv_model import engine as OHLCVEngine
from app.models.news_model import engine as NewsEngine

os.makedirs("logs", exist_ok=True)

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()

# Configurar as chaves de API
openai_api_key = os.getenv("OPENAI_API_KEY")
news_api_key = os.getenv("NEWS_API_KEY")

# Configurar Loguru para salvar logs em um arquivo
logger.add("logs/app.log", rotation="1 MB", retention="10 days")

# Verificar e criar tabelas se necessário
def check_and_create_tables():
    inspector = inspect(OHLCVEngine)
    if not inspector.has_table('ohlcv'):
        create_tables()

    inspector = inspect(NewsEngine)
    if not inspector.has_table('news'):
        create_tables()

def main(ticker):
    try:
        check_and_create_tables()
        
        #Data Controller
        logger.debug("Starting Data Controller.")
        try:
            data_controller = DataController(news_api_key)
            logger.debug("Finished.")
        except Exception as e:
            logger.error(f"An error occurred: {e}")
        
        #Sentiment Controller
        logger.debug("Started Sentiment Controller.")
        try:
            sentiment_controller = SentimentController(openai_api_key)
            logger.debug("Finished.")
        except Exception as e:
            logger.error(f"An error occurred: {e}")
        
        #Report View
        logger.debug("Started Report View.")
        try:
            report_view = ReportView()
            logger.debug("Finished.")
        except Exception as e:
            logger.error(f"An error occurred: {e}")

        #Get OHLCV data
        logger.debug("Started Get OHLCV data.")
        try:
            ohlcv_data = data_controller.get_ohlcv_data(ticker)
            logger.debug("Finished.")
        except Exception as e:
            logger.error(f"An error occurred: {e}")
        
        #Get News data
        logger.debug("Started Get News data.")
        try:
            news_data = data_controller.get_news_data(ticker)
            logger.debug("Finished.")
        except Exception as e:
            logger.error(f"An error occurred: {e}")
        
        #Analyze Sentiment
        logger.debug("Started Analyze Sentiment.")
        try:
            sentiments = sentiment_controller.analyze_sentiment(news_data)
            logger.debug("Finished.")
        except Exception as e:
            logger.error(f"An error occurred: {e}")
        
        #Report
        logger.debug("Started Report.")
        try:
            report = report_view.generate_report(ticker, ohlcv_data, sentiments)
            logger.debug("Finished.")
        except Exception as e:
            logger.error(f"An error occurred: {e}")
        
        print(report)
    except Exception as e:
        logger.error(f"An error occurred: {e}")
        # Adicionar a lógica de notificação aqui (por exemplo, email, Telegram, Slack)

if __name__ == "__main__":
    ticker = "AAPL"  # Ticker de exemplo
    main(ticker)
