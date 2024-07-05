from sqlalchemy import inspect
from app.models.ohlcv_model import Base as OHLCVBase, engine as OHLCVEngine
from app.models.news_model import Base as NewsBase, engine as NewsEngine

def create_tables():
    inspector = inspect(OHLCVEngine)
    if not inspector.has_table('ohlcv'):
        OHLCVBase.metadata.create_all(bind=OHLCVEngine)
    
    inspector = inspect(NewsEngine)
    if not inspector.has_table('news'):
        NewsBase.metadata.create_all(bind=NewsEngine)
