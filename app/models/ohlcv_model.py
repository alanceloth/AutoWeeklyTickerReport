import os
from sqlalchemy import Column, Integer, String, Float, Date, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv
from loguru import logger

load_dotenv()

logger.debug("Calling declarative_base")
Base = declarative_base()

class OHLCV(Base):
    __tablename__ = 'ohlcv'

    id = Column(Integer, primary_key=True)
    ticker = Column(String, nullable=False)
    date = Column(Date, nullable=False)
    open = Column(Float, nullable=False)
    high = Column(Float, nullable=False)
    low = Column(Float, nullable=False)
    close = Column(Float, nullable=False)
    volume = Column(Integer, nullable=False)

logger.debug("Loading env variable DATABASE_URL")
DATABASE_URL = os.getenv("DATABASE_URL")
logger.debug("Creating Engine")
engine = create_engine(DATABASE_URL)
logger.debug(f"Engine Created: {engine}")
logger.debug("Creating Session")
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
