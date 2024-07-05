def test_ohlcv_model():
    from app.models.ohlcv_model import OHLCV
    ohlcv = OHLCV(100, 110, 90, 105, 1000)
    assert ohlcv.open == 100
    assert ohlcv.high == 110
    assert ohlcv.low == 90
    assert ohlcv.close == 105
    assert ohlcv.volume == 1000

