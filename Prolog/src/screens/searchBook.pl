:- module(screens_searchBook, [screen/3]).
:- encoding(utf8).

:- use_module("./src/utils.pl").
:- use_module("./src/screens/main.pl", []).

screen('search_book', Name, Page):-
    cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nLoading\n=-=-=-=-=-=-=-=-=-=\n'),
    cls,
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
searchBookOption(NumString, Name, _):-
    number_string(Num, NumString),
    Num >= 1,
    Num =< 5, % Mudar pelo length
    writeln('Opção escolhida'),
    enterDetailsDisplay(Name),
    utis:waitInput.
searchBookOption(_, Name, Page):-
    writeln('Invalid option! Try again.'),
    read_line_to_string(user_input, Choice),
    searchBookOption(Choice, Name, Page).

enterDetailsDisplay(BookApi):-
    writeln('Enter a rate for the book: '),
    read_line_to_string(user_input, RateString),
    number_string(RateInt, RateString),
    utils:rateValidation(RateInt, Rate),
    writeln('Enter a description for the book: '),
    read_line_to_string(user_input, Description),
    % Falta a parte de pastas
    writeln(BookApi),
    writeln(Rate),
    writeln(Description).
    

% Falta a data
