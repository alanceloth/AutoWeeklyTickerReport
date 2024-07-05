import yfinance as yf
import requests

class DataFetcher:
    def __init__(self, news_api_key):
        self.news_api_key = news_api_key

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
        url = f"https://newsapi.org/v2/everything?q={ticker}&apiKey={self.news_api_key}"
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
