from app.utils.data_fetcher import DataFetcher

class DataController:
    def __init__(self, news_api_key):
        self.data_fetcher = DataFetcher(news_api_key)

    def get_ohlcv_data(self, ticker):
        return self.data_fetcher.fetch_ohlcv(ticker)

    def get_news_data(self, ticker):
        return self.data_fetcher.fetch_news(ticker)
