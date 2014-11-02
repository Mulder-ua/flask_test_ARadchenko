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
    authors = SelectField("Choose...", [(None, "Choose...")])
    del_author = SelectField("Choose...", [(None, "Choose...")])
    del_book = SelectField("Choose...", [(None, "Choose...")])
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

def modify_db(query, argument):
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
    form = LoginForm()
    error = None
    if request.method == 'POST' and request.form["btn"] == "Login":
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

    if request.method == 'POST' and request.form["btn"] == "Authors":
        search_request = " where a_name like '%" + search_string + "%' order by name"
        q = query_to_db("select author_id, name a_name from authors",search_request, False)
        s = []
        for l in q:
            s.append(l["a_name"])
        result = s

    if request.method == 'POST' and request.form["btn"] == "Books":
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
    authors = [(None, "Choose...")]
    books = [(None, "Choose...")]
    if g.user is None:
        flash("You have to authorized.")
        return redirect('/login')
    form = EditForm()

    q = query_to_db("select author_id, name a_name from authors order by name","", False)

    authors += [(s["author_id"], s["a_name"]) for s in q]
    form.authors.choices    = authors
    form.del_author.choices = authors

    q = query_to_db("select book_id, name b_name from books order by name","", False)

    books += [(s["book_id"], s["b_name"]) for s in q]
    form.del_book.choices = books

    if request.method == 'POST' and request.form["btn"] == "Add author":
        author_for_add = request.form['add_author']
        if len(author_for_add) < 2 or len(author_for_add) > 70:
            error = "Name has to be bigger then 1 and less then 70!"
        elif query_to_db('select * from authors where name = :1', author_for_add, one=True) is not None:
            error = "Author already exist in database!"
        else:
            modify_db("insert into authors(name)values(:1)", author_for_add)
            flash('Author "' + request.form['add_author'] + '" was added')
            return redirect('/edit')

    if request.method == 'POST' and request.form["btn"] == "Add book":
        book_for_add = request.form['add_book']

        if request.form["authors"] == "None":
            error = "You have to choose author!"
        elif len(book_for_add) < 2 or len(book_for_add) > 70:
            error = "Name has to be bigger then 1 and less then 70!"
        elif query_to_db('select * from books where name = :1', book_for_add, one=True) is not None:
            error = "Book already exist in database!"
        else:
            modify_db("insert into books(name)values(:1)", book_for_add)
            modify_db("insert into relation values((select book_id from books where name = :1), (:2))", (book_for_add, request.form["authors"]))
            flash('Book "' + request.form['add_book'] + '" was added')
            return redirect('/edit')

    if request.method == 'POST' and request.form["btn"] == "Del author":
        author_for_del = request.form["del_author"]
        if request.form["del_author"] == "None":
            error = "You have to choose author!"
        elif query_to_db('select * from authors where author_id = :1', author_for_del, one=True) is None:
            flash("Author not exist in database!")
            return redirect("/edit")
        else:

            name = query_to_db("select name from authors where author_id = :1", author_for_del, True)["name"]
            modify_db("delete from books where book_id in (select book_id from relation where author_id = :1)", author_for_del)
            modify_db("delete from relation where author_id = :1", author_for_del)
            modify_db("delete from authors where author_id = :1", author_for_del)
            flash('Author "' + name + '" and all related books were deleted')
            return redirect("/edit")

    if request.method == 'POST' and request.form["btn"] == "Del book":
        book_for_del = request.form["del_book"]
        if request.form["del_book"] == "None":
            error = "You have to choose author!"
        elif query_to_db('select * from books where book_id = :1', book_for_del, one=True) is None:
            flash("Author not exist in database!")
            return redirect("/edit")
        else:

            name = query_to_db("select name from books where book_id = :1", book_for_del, True)["name"]

            modify_db("delete from relation where book_id = :1", book_for_del)
            modify_db("delete from books where book_id = :1", book_for_del)
            flash('Book "' + name + '" was deleted')
            return redirect("/edit")

    return render_template("edit.html",
                           title = title,
                           form = form,
                           error = error)