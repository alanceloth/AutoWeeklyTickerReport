from app.controllers.data_controller import DataController
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

