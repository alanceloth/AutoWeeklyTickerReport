def test_report_view():
    from app.views.report_view import ReportView
    report_view = ReportView()
    report = report_view.generate_report("AAPL", [{"Date": "2021-01-01", "Open": 100, "High": 110, "Low": 90, "Close": 105, "Volume": 1000}], ["Positive"])
    assert "Report for AAPL" in report
    assert "OHLCV Data" in report
    assert "Sentiments" in report

