:- module(screens, [screen/3]).
:- encoding(utf8).

:- use_module("./src/utils.pl").

screen('start', NextScreen, _):-
    writeln('\n=-=-=-=-=-=-=-=-=-=\nMy Reading Journal\n=-=-=-=-=-=-=-=-=-=\n\n\c
        1) Add books\n\c
        2) Edit books\n\c
        3) List books\n\c
        4) Delete books\n\c
        5) See book suggestion\n\c
        6) Edit reading goal\n\n\c
        7) Exit\n\n\n\c
        Your choice: '),
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
    NextScreen = Next.

screen('add_book', Content, _):-
    Content= 
        '\n=-=-=-=-=-=-=-=-=-=\nAdd book\n=-=-=-=-=-=-=-=-=-=\n\c
        Enter the name of the book or "v" to go back:'.

screen('search_book', Content, _):-
    Content= 
        '\n=-=-=-=-=-=-=-=-=-=\nSearch Book\n=-=-=-=-=-=-=-=-=-=\n'.

screen('exit', _, _):-
    writeln('\nAté mais!\n'),
    halt.
