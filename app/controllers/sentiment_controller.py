from app.utils.report_generator import ReportGenerator

class SentimentController:
    def __init__(self, openai_api_key):
        self.report_generator = ReportGenerator(openai_api_key)

    def analyze_sentiment(self, news):
        return self.report_generator.analyze_sentiment(news)
