import openai

class ReportGenerator:
    def __init__(self):
        openai.api_key = "YOUR_API_KEY"

    def analyze_sentiment(self, news):
        sentiments = []
        for article in news:
            response = openai.Completion.create(
                model="text-davinci-003",
                prompt=f"Analyze the sentiment of this news article: {article["title"]}",
                max_tokens=50
            )
            sentiment = response.choices[0].text.strip()
            sentiments.append({
                "title": article["title"],
                "sentiment": sentiment
            })
        return sentiments

