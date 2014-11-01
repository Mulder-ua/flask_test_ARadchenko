from sqlalchemy import create_engine, MetaData
from app import core
import os



db = os.path.abspath("app\\db\\library_database.db")

engine = create_engine('sqlite:///'+db, convert_unicode=True)
metadata = MetaData(bind=engine)



f = 'A'
search_request = "a.name like '%" + f + "%'"
s = []

q = engine.execute("select a.author_id, a.name a_name, b.name b_name from relation r join authors a on r.author_id = a.author_id join books b on r.book_id = b.book_id where " +search_request )

for a in q:
    s.append(a)

print(s[0]['b_name'])
#for row in engine.execute("select a.author_id, a.name a_name, b.name b_name from relation r join authors a on r.author_id = a.author_id join books b on r.book_id = b.book_id where " +search_request ):
#   s.append(row)

#for row in engine.execute("select * from authors where name like '%" + s + "%'"):
#    print(row)




