from app.utils.report_generator import ReportGenerator

class SentimentController:
    def __init__(self):
        self.report_generator = ReportGenerator()

    def analyze_sentiment(self, news):
        return self.report_generator.analyze_sentiment(news)

