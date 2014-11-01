drop table if exists users;
create table users (
user_id integer primary key autoincrement,
login         varchar(25) not null,
password_hash varchar(25) not null
);

drop table if exists authors;
create table authors (
author_id integer primary key autoincrement,
name         varchar(25) not null
);


drop table if exists books;
create table books (
book_id integer primary key autoincrement,
name         varchar(25) not null
);


drop table if exists relation;
create table relation (
book_id integer not null,
author_id integer not null,
primary key (book_id, author_id)
);

insert into users(login, password_hash) values('Admin', 'Admin');

drop table if exists tmp_authors_books;
create table tmp_authors_books(
		book   varchar(70),
		author varchar(70)
		);
		
insert into tmp_authors_books(book, author)
values('The Lord of the Rings', 'J. R. R. Tolkien');

insert into tmp_authors_books(book, author) values('Pride and Prejudice', 'Jane Austen');;
insert into tmp_authors_books(book, author) values ('His Dark Materials', 'Philip Pullman');
insert into tmp_authors_books(book, author) values ('The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams');
insert into tmp_authors_books(book, author) values ('Harry Potter and the Goblet of Fire', 'J. K. Rowling');
insert into tmp_authors_books(book, author) values ('To Kill a Mockingbird', 'Harper Lee');
insert into tmp_authors_books(book, author) values ('Winnie-the-Pooh', 'A. A. Milne');
insert into tmp_authors_books(book, author) values ('Nineteen Eighty-Four', 'George Orwell');
insert into tmp_authors_books(book, author) values ('The Lion, the Witch and the Wardrobe', 'C. S. Lewis');
insert into tmp_authors_books(book, author) values ('Jane Eyre', 'Charlotte Brontë');
insert into tmp_authors_books(book, author) values ('Catch-22', 'Joseph Heller');
insert into tmp_authors_books(book, author) values ('Wuthering Heights', 'Emily Brontë');
insert into tmp_authors_books(book, author) values ('Birdsong', 'Sebastian Faulks');
insert into tmp_authors_books(book, author) values ('Rebecca', 'Daphne du Maurier');
insert into tmp_authors_books(book, author) values ('The Catcher in the Rye', 'J. D. Salinger');
insert into tmp_authors_books(book, author) values ('The Wind in the Willows', 'Kenneth Grahame');
insert into tmp_authors_books(book, author) values ('Great Expectations', 'Charles Dickens');
insert into tmp_authors_books(book, author) values ('Little Women', 'Louisa May Alcott');
insert into tmp_authors_books(book, author) values ('Captain Corelli''s Mandolin', 'Louis de Bernières');
insert into tmp_authors_books(book, author) values ('War and Peace', 'Leo Tolstoy');
insert into tmp_authors_books(book, author) values ('Gone with the Wind', 'Margaret Mitchell');
insert into tmp_authors_books(book, author) values ('Harry Potter and the Philosopher''s Stone', 'J. K. Rowling');
insert into tmp_authors_books(book, author) values ('Harry Potter and the Chamber of Secrets', 'J. K. Rowling');
insert into tmp_authors_books(book, author) values ('Harry Potter and the Prisoner of Azkaban', 'J. K. Rowling');
insert into tmp_authors_books(book, author) values ('The Hobbit', 'J. R. R. Tolkien');
insert into tmp_authors_books(book, author) values ('Tess of the d''Urbervilles', 'Thomas Hardy');
insert into tmp_authors_books(book, author) values ('Middlemarch', 'George Eliot');
insert into tmp_authors_books(book, author) values ('A Prayer for Owen Meany', 'John Irving');
insert into tmp_authors_books(book, author) values ('The Grapes of Wrath', 'John Steinbeck');
insert into tmp_authors_books(book, author) values ('Alice''s Adventures in Wonderland', 'Lewis Carroll');
insert into tmp_authors_books(book, author) values ('The Story of Tracy Beaker', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('One Hundred Years of Solitude', 'Gabriel García Márquez');
insert into tmp_authors_books(book, author) values ('The Pillars of the Earth', 'Ken Follett');
insert into tmp_authors_books(book, author) values ('David Copperfield', 'Charles Dickens');
insert into tmp_authors_books(book, author) values ('Charlie and the Chocolate Factory', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('Treasure Island', 'Robert Louis Stevenson');
insert into tmp_authors_books(book, author) values ('A Town Like Alice', 'Nevil Shute');
insert into tmp_authors_books(book, author) values ('Persuasion', 'Jane Austen');
insert into tmp_authors_books(book, author) values ('Dune', 'Frank Herbert');
insert into tmp_authors_books(book, author) values ('Emma', 'Jane Austen');
insert into tmp_authors_books(book, author) values ('Anne of Green Gables', 'Lucy Maud Montgomery');
insert into tmp_authors_books(book, author) values ('Watership Down', 'Richard Adams');
insert into tmp_authors_books(book, author) values ('The Great Gatsby', 'F. Scott Fitzgerald');
insert into tmp_authors_books(book, author) values ('The Count of Monte Cristo', 'Alexandre Dumas');
insert into tmp_authors_books(book, author) values ('Brideshead Revisited', 'Evelyn Waugh');
insert into tmp_authors_books(book, author) values ('Animal Farm', 'George Orwell');
insert into tmp_authors_books(book, author) values ('A Christmas Carol', 'Charles Dickens');
insert into tmp_authors_books(book, author) values ('Far from the Madding Crowd', 'Thomas Hardy');
insert into tmp_authors_books(book, author) values ('Goodnight Mister Tom', 'Michelle Magorian');
insert into tmp_authors_books(book, author) values ('The Shell Seekers', 'Rosamunde Pilcher');
insert into tmp_authors_books(book, author) values ('The Secret Garden', 'Frances Hodgson Burnett');
insert into tmp_authors_books(book, author) values ('Of Mice and Men', 'John Steinbeck');
insert into tmp_authors_books(book, author) values ('The Stand', 'Stephen King');
insert into tmp_authors_books(book, author) values ('Anna Karenina', 'Leo Tolstoy');
insert into tmp_authors_books(book, author) values ('A Suitable Boy', 'Vikram Seth');
insert into tmp_authors_books(book, author) values ('The BFG', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('Swallows and Amazons', 'Arthur Ransome');
insert into tmp_authors_books(book, author) values ('Black Beauty', 'Anna Sewell');
insert into tmp_authors_books(book, author) values ('Artemis Fowl', 'Eoin Colfer');
insert into tmp_authors_books(book, author) values ('Crime and Punishment', 'Fyodor Dostoevsky');
insert into tmp_authors_books(book, author) values ('Noughts & Crosses', 'Malorie Blackman');
insert into tmp_authors_books(book, author) values ('Memoirs of a Geisha', 'Arthur Golden');
insert into tmp_authors_books(book, author) values ('A Tale of Two Cities', 'Charles Dickens');
insert into tmp_authors_books(book, author) values ('The Thorn Birds', 'Colleen McCullough');
insert into tmp_authors_books(book, author) values ('Mort', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('The Magic Faraway Tree', 'Enid Blyton');
insert into tmp_authors_books(book, author) values ('The Magus', 'John Fowles');
insert into tmp_authors_books(book, author) values ('Good Omens', 'Neil Gaiman and Terry Pratchett');
insert into tmp_authors_books(book, author) values ('Guards! Guards!', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('Lord of the Flies', 'William Golding');
insert into tmp_authors_books(book, author) values ('Perfume', 'Patrick Süskind');
insert into tmp_authors_books(book, author) values ('The Ragged-Trousered Philanthropists', 'Robert Tressell');
insert into tmp_authors_books(book, author) values ('Night Watch', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('Matilda', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('Bridget Jones''s Diary', 'Helen Fielding');
insert into tmp_authors_books(book, author) values ('The Secret History', 'Donna Tartt');
insert into tmp_authors_books(book, author) values ('The Woman in White', 'Wilkie Collins');
insert into tmp_authors_books(book, author) values ('Ulysses', 'James Joyce');
insert into tmp_authors_books(book, author) values ('Bleak House', 'Charles Dickens');
insert into tmp_authors_books(book, author) values ('Double Act', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('The Twits', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('I Capture the Castle', 'Dodie Smith');
insert into tmp_authors_books(book, author) values ('Holes', 'Louis Sachar');
insert into tmp_authors_books(book, author) values ('Gormenghast', 'Mervyn Peake');
insert into tmp_authors_books(book, author) values ('The God of Small Things', 'Arundhati Roy');
insert into tmp_authors_books(book, author) values ('Vicky Angel', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('Brave New World', 'Aldous Huxley');
insert into tmp_authors_books(book, author) values ('Cold Comfort Farm', 'Stella Gibbons');
insert into tmp_authors_books(book, author) values ('Magician', 'Raymond E. Feist');
insert into tmp_authors_books(book, author) values ('On the Road', 'Jack Kerouac');
insert into tmp_authors_books(book, author) values ('The Godfather', 'Mario Puzo');
insert into tmp_authors_books(book, author) values ('The Clan of the Cave Bear', 'Jean M. Auel');
insert into tmp_authors_books(book, author) values ('The Colour of Magic', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('The Alchemist', 'Paulo Coelho');
insert into tmp_authors_books(book, author) values ('Katherine', 'Anya Seton');
insert into tmp_authors_books(book, author) values ('Kane and Abel', 'Jeffrey Archer');
insert into tmp_authors_books(book, author) values ('Love in the Time of Cholera', 'Gabriel García Márquez');
insert into tmp_authors_books(book, author) values ('Girls in Love', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('The Princess Diaries', 'Meg Cabot');
insert into tmp_authors_books(book, author) values ('Midnight''s Children', 'Salman Rushdie');
insert into tmp_authors_books(book, author) values ('Three Men in a Boat', 'Jerome K. Jerome');
insert into tmp_authors_books(book, author) values ('Small Gods', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('The Beach', 'Alex Garland');
insert into tmp_authors_books(book, author) values ('Dracula', 'Bram Stoker');
insert into tmp_authors_books(book, author) values ('Point Blanc', 'Anthony Horowitz');
insert into tmp_authors_books(book, author) values ('The Pickwick Papers', 'Charles Dickens');
insert into tmp_authors_books(book, author) values ('Stormbreaker', 'Anthony Horowitz');
insert into tmp_authors_books(book, author) values ('The Wasp Factory', 'Iain Banks');
insert into tmp_authors_books(book, author) values ('The Day of the Jackal', 'Frederick Forsyth');
insert into tmp_authors_books(book, author) values ('The Illustrated Mum', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('Jude the Obscure', 'Thomas Hardy');
insert into tmp_authors_books(book, author) values ('The Secret Diary of Adrian Mole, Aged 13¾', 'Sue Townsend');
insert into tmp_authors_books(book, author) values ('The Cruel Sea', 'Nicholas Monsarrat');
insert into tmp_authors_books(book, author) values ('Les Misérables', 'Victor Hugo');
insert into tmp_authors_books(book, author) values ('The Mayor of Casterbridge', 'Thomas Hardy');
insert into tmp_authors_books(book, author) values ('The Dare Game', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('Bad Girls', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('The Picture of Dorian Gray', 'Oscar Wilde');
insert into tmp_authors_books(book, author) values ('Shōgun', 'James Clavell');
insert into tmp_authors_books(book, author) values ('The Day of the Triffids', 'John Wyndham');
insert into tmp_authors_books(book, author) values ('Lola Rose', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('Vanity Fair', 'William Makepeace Thackeray');
insert into tmp_authors_books(book, author) values ('The Forsyte Saga', 'John Galsworthy');
insert into tmp_authors_books(book, author) values ('House of Leaves', 'Mark Z. Danielewski');
insert into tmp_authors_books(book, author) values ('The Poisonwood Bible', 'Barbara Kingsolver');
insert into tmp_authors_books(book, author) values ('Reaper Man', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('Angus, Thongs and Full-Frontal Snogging', 'Louise Rennison');
insert into tmp_authors_books(book, author) values ('The Hound of the Baskervilles', 'Arthur Conan Doyle');
insert into tmp_authors_books(book, author) values ('Possession: A Romance', 'A. S. Byatt');
insert into tmp_authors_books(book, author) values ('The Master and Margarita', 'Mikhail Bulgakov');
insert into tmp_authors_books(book, author) values ('The Handmaid''s Tale', 'Margaret Atwood');
insert into tmp_authors_books(book, author) values ('Danny, the Champion of the World', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('East of Eden', 'John Steinbeck');
insert into tmp_authors_books(book, author) values ('George''s Marvellous Medicine', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('Wyrd Sisters', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('The Color Purple', 'Alice Walker');
insert into tmp_authors_books(book, author) values ('Hogfather', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('The Thirty-nine Steps', 'John Buchan');
insert into tmp_authors_books(book, author) values ('Girls in Tears', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('Sleepovers', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('All Quiet on the Western Front', 'Erich Maria Remarque');
insert into tmp_authors_books(book, author) values ('Behind the Scenes at the Museum', 'Kate Atkinson');
insert into tmp_authors_books(book, author) values ('High Fidelity', 'Nick Hornby');
insert into tmp_authors_books(book, author) values ('It', 'Stephen King');
insert into tmp_authors_books(book, author) values ('James and the Giant Peach', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('The Green Mile', 'Stephen King');
insert into tmp_authors_books(book, author) values ('Papillon', 'Henri Charrière');
insert into tmp_authors_books(book, author) values ('Men at Arms', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('Master and Commander', 'Patrick O''Brian');
insert into tmp_authors_books(book, author) values ('Skeleton Key', 'Anthony Horowitz');
insert into tmp_authors_books(book, author) values ('Soul Music', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('Thief of Time', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('The Fifth Elephant', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('Atonement', 'Ian McEwan');
insert into tmp_authors_books(book, author) values ('Secrets', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('The Silver Sword', 'Ian Serraillier');
insert into tmp_authors_books(book, author) values ('One Flew Over the Cuckoo''s Nest', 'Ken Kesey');
insert into tmp_authors_books(book, author) values ('Heart of Darkness', 'Joseph Conrad');
insert into tmp_authors_books(book, author) values ('Kim', 'Rudyard Kipling');
insert into tmp_authors_books(book, author) values ('Cross Stitch', 'Diana Gabaldon');
insert into tmp_authors_books(book, author) values ('Moby-Dick', 'Herman Melville');
insert into tmp_authors_books(book, author) values ('River God', 'Wilbur Smith');
insert into tmp_authors_books(book, author) values ('Sunset Song', 'Lewis Grassic Gibbon');
insert into tmp_authors_books(book, author) values ('The Shipping News', 'E. Annie Proulx');
insert into tmp_authors_books(book, author) values ('The World According to Garp', 'John Irving');
insert into tmp_authors_books(book, author) values ('Lorna Doone', 'R. D. Blackmore');
insert into tmp_authors_books(book, author) values ('Girls Out Late', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('The Far Pavilions', 'M. M. Kaye');
insert into tmp_authors_books(book, author) values ('The Witches', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('Charlotte''s Web', 'E. B. White');
insert into tmp_authors_books(book, author) values ('Frankenstein', 'Mary Shelley');
insert into tmp_authors_books(book, author) values ('They Used to Play on Grass', 'Terry Venables and Gordon Williams');
insert into tmp_authors_books(book, author) values ('The Old Man and the Sea', 'Ernest Hemingway');
insert into tmp_authors_books(book, author) values ('The Name of the Rose', 'Umberto Eco');
insert into tmp_authors_books(book, author) values ('Sophie''s World', 'Jostein Gaarder');
insert into tmp_authors_books(book, author) values ('Dustbin Baby', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('Fantastic Mr. Fox', 'Roald Dahl');
insert into tmp_authors_books(book, author) values ('Lolita', 'Vladimir Nabokov');
insert into tmp_authors_books(book, author) values ('Jonathan Livingston Seagull', 'Richard Bach');
insert into tmp_authors_books(book, author) values ('The Little Prince', 'Antoine de Saint-Exupéry');
insert into tmp_authors_books(book, author) values ('The Suitcase Kid', 'Jacqueline Wilson');
insert into tmp_authors_books(book, author) values ('Oliver Twist', 'Charles Dickens');
insert into tmp_authors_books(book, author) values ('The Power of One', 'Bryce Courtenay');
insert into tmp_authors_books(book, author) values ('Silas Marner', 'George Eliot');
insert into tmp_authors_books(book, author) values ('American Psycho', 'Bret Easton Ellis');
insert into tmp_authors_books(book, author) values ('Diary of a Nobody', 'George and Weedon Grossmith');
insert into tmp_authors_books(book, author) values ('Trainspotting', 'Irvine Welsh');
insert into tmp_authors_books(book, author) values ('Goosebumps', 'R. L. Stine');
insert into tmp_authors_books(book, author) values ('Heidi', 'Johanna Spyri');
insert into tmp_authors_books(book, author) values ('Sons and Lovers', 'D. H. Lawrence');
insert into tmp_authors_books(book, author) values ('The Unbearable Lightness of Being', 'Milan Kundera');
insert into tmp_authors_books(book, author) values ('Man and Boy', 'Tony Parsons');
insert into tmp_authors_books(book, author) values ('The Truth', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('The War of the Worlds', 'H. G. Wells');
insert into tmp_authors_books(book, author) values ('The Horse Whisperer', 'Nicholas Evans');
insert into tmp_authors_books(book, author) values ('A Fine Balance', 'Rohinton Mistry');
insert into tmp_authors_books(book, author) values ('Witches Abroad', 'Terry Pratchett');
insert into tmp_authors_books(book, author) values ('The Once and Future King', 'T. H. White');
insert into tmp_authors_books(book, author) values ('The Very Hungry Caterpillar', 'Eric Carle');
insert into tmp_authors_books(book, author) values ('Flowers in the Attic', 'V. C. Andrews');

insert into authors(name) select distinct author from tmp_authors_books;

insert into books(name) select distinct book from tmp_authors_books;

insert into relation select b.book_id, a.author_id,  from tmp_authors_books tmp join authors a on tmp.author = a.name join books b on tmp.book = b.name;

drop table tmp_authors_books;
