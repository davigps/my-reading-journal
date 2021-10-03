:- module(controllers_books, []).

:- use_module("./src/utils/files.pl", []).
:- use_module(library(apply)).

indexBooks(Books):-
    utils_files:get_dict_from_json_file("./data/books.json", BooksFile),
    Books = BooksFile.get('books').

createBook(Book) :-
    indexBooks(SavedBooks),
    append(SavedBooks, [Book], ResultBooks),
    utils_files:save_dict_to_json_file("./data/books.json", _{
        'books': ResultBooks
    }).

readBook(BookTitle, SearchedBook) :-
    indexBooks(SavedBooks),
    exclude(booksAreNotIdentical(BookTitle), SavedBooks, [SearchedBook]).

updateBook(BookTitle, NewBook) :-
    deleteBook(BookTitle),
    createBook(NewBook).

deleteBook(BookTitle) :-
    indexBooks(SavedBooks),
    exclude(booksAreIdentical(BookTitle), SavedBooks, NewBooks),
    utils_files:save_dict_to_json_file("./data/books.json", _{
        'books': NewBooks
    }).

booksAreIdentical(X, Y) :-
    X = Y.get('title').

booksAreNotIdentical(X, Y) :-
    X \= Y.get('title').