:- module(screens_searchBook, [screen/3]).
:- encoding(utf8).

:- use_module("./src/utils.pl").
:- use_module("./src/screens/main.pl", []).

screen('search_book', Name, Page):-
    %%tty_clear,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nLoading\n=-=-=-=-=-=-=-=-=-=\n'),
    %tty_clear,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nSearch Results\n=-=-=-=-=-=-=-=-=-=\n'),
    writeln(Name),
    writeln(Page),
    writeln('Enter the option number (1...5)\n\c
        or "c" to cancel\n\c
        or "n" to see next page\n\c
        or "p" to see previous page\n\c
        Your choice:\n'),
    read_line_to_string(user_input, Choice),
    searchBookOption(Choice, Name, Page).

searchBookOption("c", _, _):- screens_main:screen('start').
searchBookOption("n", Name, Page):- % Verificar a quantidade máxima de páginas
    NewPage is Page + 1,
    screen('search_book', Name, NewPage).
searchBookOption("p", Name, Page):- 
    NewPage is Page - 1,
    (Page =:= 1 -> screen('search_book', Name, Page);
        screen('search_book', Name, NewPage)).
searchBookOption(NumString, _, _):-
    number_string(Num, NumString),
    Num >= 1,
    Num =< 5,
    writeln('Opção escolhida'),
    utis:waitInput.
searchBookOption(_, Name, Page):-
    writeln('Opção inválida! Tente novamente.'),
    read_line_to_string(user_input, Choice),
    searchBookOption(Choice, Name, Page).