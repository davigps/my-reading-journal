:- encoding(utf8).

:- use_module("./src/app/screens.pl").
:- use_module("./src/utils.pl").

main :-
    (current_prolog_flag(unix, _), utils:cls;true),
    screen('start').
    