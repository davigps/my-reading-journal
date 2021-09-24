:- module(screens_books, [screen/1]).
:- encoding(utf8).

:- use_module("./src/screens/main.pl", []).
:- use_module("./src/screens/searchBook.pl", []).

screen('add_book'):-
    cls,    
    writeln('\n=-=-=-=-=-=-=-=-=-=\nAdd book\n=-=-=-=-=-=-=-=-=-=\n\c
        Enter the name of the book or "v" to go back:'),
    read_line_to_string(user_input, Name),
    (Name == "v" -> screens_main:screen('start'); 
        screens_searchBook:screen('search_book', Name, 1)).
