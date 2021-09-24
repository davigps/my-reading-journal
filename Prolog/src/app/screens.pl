:- module(screens, [screen/1]).
:- encoding(utf8).

:- use_module("./src/utils.pl").

screen('start'):-
    writeln('\n=-=-=-=-=-=-=-=-=-=\nMy Reading Journal\n=-=-=-=-=-=-=-=-=-=\n\n\c
        1) Add books\n\c
        2) Edit books\n\c
        3) List books\n\c
        4) Delete books\n\c
        5) See book suggestion\n\c
        6) Edit reading goal\n\n\c
        7) Exit\n\n\n\c
        Your choice:\n'),
    NextScreens = _{
        '1':'add_book',
        '2':'edit_book',
        '3':'list_books',
        '4':'delete_books',
        '5':'book_suggestion',
        '6':'edit_goal',
        '7':'exit'
    },
    utils:promptChoice(NextScreens, Next),
    screen(Next).

screen('add_book'):-
    writeln('\n=-=-=-=-=-=-=-=-=-=\nAdd book\n=-=-=-=-=-=-=-=-=-=\n\c
        Enter the name of the book or "v" to go back:'),
    read_line_to_string(user_input, Name),
    (Name == "v" -> screen('start'); 
        screen('search_book', Name, 1)).
    

screen('search_book', Name, Page):-
    writeln('\n=-=-=-=-=-=-=-=-=-=\nLoading\n=-=-=-=-=-=-=-=-=-=\n'),
    (current_prolog_flag(unix, _), utils:cls;true),
    writeln('\n=-=-=-=-=-=-=-=-=-=\nSearch Results\n=-=-=-=-=-=-=-=-=-=\n'),
    writeln(Name),
    writeln('Enter the option number (1...5)\n\c
        or 'c' to cancel\n\c
        or 'n' to see next page\n\c
        or 'p' to see previous page\n\c
        Your choice:\n'),
    read_line_to_string(user_input, Choice),
    (Choice == "c" -> screen('start');
    (Choice == "n" -> screen('search_book', Name, Page + 1); /* ver parte do length*/
    Choice == "p", Page =\= 1 -> screen('search_book', Name, Page - 1))),
    screen('start').
    
    /* Listagem */

Enter the option number (1...5)
or 'c' to cancel
or 'n' to see next page
or 'p' to see previous page
Your choice:



screen('exit'):-
    writeln('\nAté mais!\n'),
    halt.
