import yfinance as yf
import requests
from app.models.ohlcv_model import OHLCV, SessionLocal
from app.models.news_model import NewsArticle
from loguru import logger

class DataFetcher:
    def __init__(self, news_api_key):
        self.news_api_key = news_api_key

    def fetch_ohlcv(self, ticker):
        try:
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
            self.save_ohlcv(ticker, ohlcv_data)
            return ohlcv_data
        except Exception as e:
            logger.error(f"An error occurred while fetching OHLCV data: {e}")

    def save_ohlcv(self, ticker, data):
        try:
            session = SessionLocal()
            for entry in data:
                ohlcv = OHLCV(
                    ticker=ticker,
                    date=entry["Date"],
                    open=entry["Open"],
                    high=entry["High"],
                    low=entry["Low"],
                    close=entry["Close"],
                    volume=entry["Volume"]
                )
                session.add(ohlcv)
            session.commit()
            session.close()
        except Exception as e:
            logger.error(f"An error occurred while saving OHLCV data: {e}")

    def fetch_news(self, ticker):
        try:
            url = f"https://newsapi.org/v2/everything?q={ticker}&apiKey={self.news_api_key}"
            response = requests.get(url)
            response.encoding = 'utf-8'  # Garantir leitura em UTF-8
            news = response.json()["articles"]
            news_data = []
            for article in news:
                news_data.append({
                    "title": article["title"],
                    "description": article["description"],
                    "url": article["url"]
                })
            self.save_news(ticker, news_data)
            return news_data
        except Exception as e:
            logger.error(f"An error occurred while fetching news data: {e}")

    def save_news(self, ticker, data):
        try:
            session = SessionLocal()
            for entry in data:
                news_article = NewsArticle(
                    ticker=ticker,
                    title=entry["title"],
                    description=entry["description"],
                    url=entry["url"],
                    sentiment=""  # Sentiment will be updated later
                )
                session.add(news_article)
            session.commit()
            session.close()
        except Exception as e:
            logger.error(f"An error occurred while saving news data: {e}")
