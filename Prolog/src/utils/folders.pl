:- module(utils_folders, []).
:- encoding(utf8).

printFolders([], _).
printFolders([Folder|Tail], Option):-
    write("\n"),  
    writeln("---------------------"),
    atom_concat('-- Option ', Option, OptionNumber),
    writeln(OptionNumber),
    writeln(Folder),
    NextOption is Option + 1,
    printFolders(Tail, NextOption).