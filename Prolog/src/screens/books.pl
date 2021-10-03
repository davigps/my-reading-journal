:- module(screens_books, [screen/1]).
:- encoding(utf8).

:- use_module("./src/screens/main.pl", []).
:- use_module("./src/screens/searchBook.pl", []).

:- use_module("./src/utils/files.pl").
:- use_module("./src/utils/books.pl").
:- use_module("./src/utils/screens.pl").

:- use_module("./src/controllers/profile.pl").
:- use_module("./src/controllers/books.pl").

screen('add_book'):-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nAdd book\n=-=-=-=-=-=-=-=-=-=\n\c
        Enter the name of the book or "v" to go back:'),
    read_line_to_string(user_input, Name),
    (Name == "v" -> screens_main:screen('start'); 
        screens_searchBook:screen('search_book', Name, 1)).

screen('edit_book'):-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nEdit book\n=-=-=-=-=-=-=-=-=-=\n'),
    % Mostra os livros
    utils_books:displayBooks,
    writeln('\nChoose an option or digit "v" to go back:'),
    read_line_to_string(user_input, Choice),
    editOption(Choice).

screen('delete_books'):-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nDelete book\n=-=-=-=-=-=-=-=-=-=\n'),
    % Mostra os livros
    writeln('\nChoose an option or digit "v" to go back:'),
    read_line_to_string(user_input, Choice),
    deleteOption(Choice).

screen('edit_goal'):-
    writeln('\n=-=-=-=-=-=-=-=-=-=\nEdit reading goal\n=-=-=-=-=-=-=-=-=-=\n'),
    writeln('\nEnter new goal or \'v\' to go back:'),
    read_line_to_string(user_input, Choice),
    editGoalOption(Choice).

 screen('list_books'):-
    utils_screens:cls,
    write('\n=-=-=-=-=-=-=-=-=-=\nList book\n=-=-=-=-=-=-=-=-=-=\n'),
    utils_books:displayBooks.

editOption("v"):-
    main:screen('start').
editOption(Choice):-
    number_string(Num, Choice),
    Num >= 1,
    Num =< 5, % Trocar pelo length
    writeln('Opção escolhida'), % Seleciona o livro
    writeln('Enter the new rate: '),
    read_line_to_string(user_input, NewRate),
    number_string(RateInt, NewRate),
    utils_books:rateValidation(RateInt, Rate),
    writeln('Enter the new description: '),
    read_line_to_string(user_input, NewDescription),
    writeln('Your book has been successfully edited!'),
    writeln(Rate),
    writeln(NewDescription),
    utils_screens:waitInput.
editOption(_):-
    writeln('Invalid option! Try again.'),
    read_line_to_string(user_input, NewChoice),
    editOption(NewChoice).

deleteOption("v"):-
    main:screen('start').
deleteOption(Choice):-
    number_string(Num, Choice),
    Num >= 1,
    Num =< 5, % Trocar pelo length
    writeln('Opção escolhida'), % Seleciona o livro
    writeln('Your book has been successfully deleted!'),
    utils_screens:waitInput.
deleteOption(_):-
    writeln('Invalid option! Try again.'),
    read_line_to_string(user_input, NewChoice),
    deleteOption(NewChoice).

editGoalOption("v"):-
    main:screen('start').
editGoalOption(Choice):-
    number_string(NumChoice, Choice),
    integer(NumChoice),
    controllers_profile:updateProfile(Choice),
    writeln('Your goal has been successfully changed!').
editGoalOption(_):-
    writeln('Invalid option! Try again.'),
    read_line_to_string(user_input, NewChoice),
    editGoalOption(NewChoice).    