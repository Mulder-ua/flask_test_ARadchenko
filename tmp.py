from sqlalchemy import create_engine, MetaData
from app import core
import os



db = os.path.abspath("app\\db\\library_database.db")

engine = create_engine('sqlite:///'+db, convert_unicode=True)
metadata = MetaData(bind=engine)




q = engine.execute("select :1 + :2 ", 1, 2)

for a in q:
    print(a)



