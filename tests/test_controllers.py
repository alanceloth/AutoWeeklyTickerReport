def test_data_controller():
    from app.controllers.data_controller import DataController
    data_controller = DataController()
    ohlcv_data = data_controller.get_ohlcv_data("AAPL")
    assert len(ohlcv_data) > 0

def test_sentiment_controller():
    from app.controllers.sentiment_controller import SentimentController
    sentiment_controller = SentimentController()
    sentiments = sentiment_controller.analyze_sentiment([{"title": "Apple hits new high"}])
    assert len(sentiments) > 0

