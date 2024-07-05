def test_data_fetcher():
    from app.utils.data_fetcher import DataFetcher
    data_fetcher = DataFetcher()
    ohlcv_data = data_fetcher.fetch_ohlcv("AAPL")
    assert len(ohlcv_data) > 0

def test_report_generator():
    from app.utils.report_generator import ReportGenerator
    report_generator = ReportGenerator()
    sentiments = report_generator.analyze_sentiment([{"title": "Apple hits new high"}])
    assert len(sentiments) > 0

