:- module(utils_folders, []).
:- encoding(utf8).

printFolders([], _).
printFolders([Folder|Tail], Option):-
    write("\n"),  
    writeln("---------------------"),
    atom_concat(Option, ') ', OptionNumber),
    atom_concat(OptionNumber, Folder, PrintFolder),
    writeln(PrintFolder),
    NextOption is Option + 1,
    printFolders(Tail, NextOption).