:- encoding(utf8).

:- use_module("./src/app/screens.pl").
:- use_module("./src/app/listeners.pl").
:- use_module("./src/utils.pl").

start:- main('start', _).

main(Type, Parameter):-
    (current_prolog_flag(unix, _), utils:cls;true),
    screen(Type,Content,NextScreens),
    writeln(Content),
    screenListener(Type,Next, Parameter),
    (nonvar(Next),!;
    promptChoice(NextScreens, Next)),
    main(Next, Parameter).
    