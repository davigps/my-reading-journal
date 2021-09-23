:- module(listeners, [screenListener/3]).
:- encoding(utf8).

:- use_module("./screens.pl").
:- use_module("./../utils.pl").

screenListener('start', _, _).

screenListener('exit', _, _):- halt.

screenListener('add_book', Next, Parameter):-
    read_line_to_string(user_input, Name),
    ((Name == "v") -> Next = 'start';
    Next = 'search_book',
    Parameter = Name).

screenListener('search_book', Next, Parameter):-
    write_ln("Pesquisando livro:"),
    write_ln(Parameter),
    utils:waitInput,
    Next = 'start'.