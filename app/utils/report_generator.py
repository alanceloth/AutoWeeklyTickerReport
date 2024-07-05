import openai

class ReportGenerator:
    def __init__(self, openai_api_key):
        openai.api_key = openai_api_key

    def analyze_sentiment(self, news):
        sentiments = []
        for article in news:
            response = openai.Completion.create(
                model="gpt-4-turbo",  # Usando GPT-4 Turbo
                prompt=f"Analyze the sentiment of this news article: {article['title']}",
                max_tokens=50
            )
            sentiment = response.choices[0].text.strip()
            sentiments.append({
                "title": article["title"],
                "sentiment": sentiment
            })
        return sentiments
