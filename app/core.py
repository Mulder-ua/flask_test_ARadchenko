from flask import render_template, flash, redirect, request, g, session
from app import app
from flask.ext.wtf import Form
from wtforms import StringField, BooleanField, PasswordField, RadioField, SelectField
from wtforms.validators import DataRequired
from sqlalchemy import create_engine, MetaData
import os
import re

db = os.path.abspath("app\\db\\library_database.db")

class MainForms(Form):
    search   = StringField('search', validators = [DataRequired()])


#Наследуем мейн форм что бы вытягивать поле для поиска
class LoginForm(MainForms):
    login    = StringField('login')
    password = PasswordField('password')


class EditForm(MainForms):
    authors = SelectField("Choose", choices=[(None, "Choose...")])



def query_to_db(query, argument, one):
    engine = create_engine('sqlite:///'+db, convert_unicode=True)
    metadata = MetaData(bind=engine)
    if one:
        result = engine.execute(query, argument).first()
    else:
        result = engine.execute(query+argument)
    return result

def get_info(search_request):
    return query_to_db("select a.author_id, a.name a_name, b.name b_name "
                "from relation r "
                "join authors a "
                " on r.author_id = a.author_id "
                "join books b "
                " on r.book_id = b.book_id "
                "where ", search_request, one=False)



@app.route('/', methods = ['GET', 'POST'])
@app.route('/index', methods = ['GET', 'POST'])
def index():
    form = MainForms()
    if request.method == 'POST' and request.form["btn"] == "Search":
        return redirect('/search')
    return render_template("index.html",
                           form = form
                           )

@app.before_request
def before_request():
    g.user = None
    if 'login' in session:
        g.user = query_to_db('select * from users where login = :1',
        [session['login']], one=True)


@app.route('/login', methods = ['GET', 'POST'])
def login():
    if g.user is not None:
      return redirect('/search')
    user_l = {"login":"Admin",
              "password_hash":"Admin"}
    form = LoginForm()
    error = None
    if  request.method == 'POST' and request.form["btn"] == "Login":
        user = query_to_db('select * from users where login = :1', request.form['login'], one=True)
        if user is None:
            error = "Invalid login"
        elif not user['password_hash'] == request.form['password']:
            error = 'Invalid password'
        else:
            flash('You were logged in')
            session['login'] = user['login']
            return redirect('/index')

    elif request.method == 'POST' and request.form["btn"] == "Search":
        return redirect('/search')

    return render_template("login.html",
                           form = form,
                           error = error
                           )


@app.route('/search', methods = ['GET', 'POST'])
def search():
    form = MainForms()

    search_string = request.form['search']
    result = None

    if  request.method == 'POST' and request.form["btn"] == "Authors":
        search_request = "a.name like '%" + search_string + "%'"
        q = get_info(search_request)
        s = []
        for l in q:
            s.append(l["a_name"])
        result = s

    if  request.method == 'POST' and request.form["btn"] == "Books":
        search_request = "b.name like '%" + search_string + "%'"
        q = get_info(search_request)
        s = []

        for l in q:
            s.append([l["b_name"], l["a_name"]])
        result = s
    return render_template("search.html",
                           form = form,
                           result = result,
                           btn = request.form["btn"],
                           request = search_string
    )

@app.route('/logout', methods = ['GET', 'POST'])
def logout():
    flash('You were logged in')
    session.pop('login')
    return redirect('/index')
    return render_template("index.html")


@app.route('/edit', methods = ['GET', 'POST'])
def edit():
    error = None
    if g.user is None:
        flash("You have to authorized.")
        return redirect('/login')
    form = EditForm()
    search_request = "a.name like '%" + "%' order by a_name "
    q = get_info(search_request)
    form.authors.choices += [(s["author_id"], s["a_name"]) for s in q]
    return render_template("edit.html",
                           form = form,
                           error = error)