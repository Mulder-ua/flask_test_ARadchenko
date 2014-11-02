from flask import render_template, flash, redirect, request, g, session
from app import app
from flask.ext.wtf import Form
from wtforms import StringField, PasswordField, SelectField
from wtforms.validators import DataRequired
from sqlalchemy import create_engine, MetaData
import os
import re

db = os.path.abspath("app\\db\\library_database.db")


class MainForms(Form):
    search = StringField('search', validators=[DataRequired()])


# Наследуем мейн форм что бы вытягивать поле для поиска
class LoginForm(MainForms):
    login = StringField('login')
    password = PasswordField('password')


class EditForm(MainForms):
    authors = SelectField("Choose...", choices=[(None, "Choose...")])
    del_author = SelectField("Choose...", choices=[(None, "Choose...")])
    del_book = SelectField("Choose...", choices=[(None, "Choose...")])
    add_author = StringField('add_author')
    add_book = StringField('add_book')


def query_to_db(query, argument, one):
    """query - тело запроса,
       argument - фильтры,
       one - True - вернуть 1 строку, False - вернуть все"""
    result = ""
    engine = create_engine('sqlite:///'+db, convert_unicode=True)
    metadata = MetaData(bind=engine)
    if one:
        result = engine.execute(query, argument).first()
    else:
        result = engine.execute(query+argument)
    return result

def modifire_db(query, argument):
    engine = create_engine('sqlite:///'+db, convert_unicode=True)
    metadata = MetaData(bind=engine)
    engine.execute(query, argument)

def get_info(search_request, sel):
    return query_to_db(
                "select " + 
                sel +
                "from relation r "
                "join authors a "
                " on r.author_id = a.author_id "
                "join books b "
                " on r.book_id = b.book_id "
                "where ", 
                search_request, 
                one=False
                )


@app.route('/', methods = ['GET', 'POST'])
@app.route('/index', methods = ['GET', 'POST'])
def index():
    title = "Home"
    form = MainForms()
    if request.method == 'POST' and request.form["btn"] == "Search":
        return redirect('/search')
    return render_template("index.html",
                           title = title,
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
    title = "Login"
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
                           title = title,
                           form = form,
                           error = error
                           )


@app.route('/search', methods = ['GET', 'POST'])
def search():
    title = "Search result"
    form = MainForms()

    search_string = request.form['search']
    result = None

    if  request.method == 'POST' and request.form["btn"] == "Authors":
        search_request = " where a_name like '%" + search_string + "%' order by name"
        q = query_to_db("select author_id, name a_name from authors",search_request, False)
        s = []
        for l in q:
            s.append(l["a_name"])
        result = s

    if  request.method == 'POST' and request.form["btn"] == "Books":
        sel = " distinct a.author_id, a.name a_name, b.name b_name "
        search_request = "b_name like '%" + search_string + "%' order by b.name"
        q = get_info(search_request, sel)
        s = []
        for l in q:
            s.append([l["b_name"], l["a_name"]])
        result = s
    return render_template("search.html",
                           title = title,
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
    title = "Edit you library"
    error = None
    authors = []
    books   = []
    if g.user is None:
        flash("You have to authorized.")
        return redirect('/login')
    form = EditForm()
    q = query_to_db("select author_id, name a_name from authors","", False)
    authors += [(s["author_id"], s["a_name"]) for s in q]
    form.authors.choices    += authors
    form.del_author.choices += authors

    q = query_to_db("select book_id, name b_name from books","", False)

    books += [(s["book_id"], s["b_name"]) for s in q]
    form.del_book.choices += books

    if  request.method == 'POST' and request.form["btn"] == "Add author":
        author_for_add = request.form['add_author']

        check_author = query_to_db('select * from authors where name = :1', request.form['add_author'], one=True)
        if check_author is not None:
            error = "Author already exist in database!"
        else:
            modifire_db("insert into authors(name)values(:1)", request.form['add_author'])
            flash(request.form['add_author'] + " was added")

    if  request.method == 'POST' and request.form["btn"] == "Add book":
        error = request.form["authors"]

    if  request.method == 'POST' and request.form["btn"] == "Del author":
        error = request.form["del_author"]

    if  request.method == 'POST' and request.form["btn"] == "Del book":
        error = request.form["del_book"]

    return render_template("edit.html",
                           title = title,
                           form = form,
                           error = error)