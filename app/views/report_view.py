class ReportView:
    def generate_report(self, ticker, ohlcv_data, sentiments):
        report = f"Report for {ticker}\n\n"
        report += "OHLCV Data:\n"
        for data in ohlcv_data:
            report += f"{data}\n"
        report += "\nSentiments:\n"
        for sentiment in sentiments:
            report += f"{sentiment}\n"
        return report

