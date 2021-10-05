:- module(utils_bookSuggestion, []).
:- encoding(utf8).

:- use_module("./src/utils/api.pl").
:- use_module("./src/utils/screens.pl").

:- use_module("./src/controllers/books.pl").

suggestionBooks:-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nLoading\n=-=-=-=-=-=-=-=-=-=\n'),
    %utils_api:requestSearchSubject('Science Fiction', Response),
    utils_screens:cls,
    %writeln(Response),
    getMostReadSubject(MostReadSubject),
    writeln(MostReadSubject),
    %Fazer a parte lógica
    controllers_books:indexBooks([Book|_]),
    write('Title: '),
    writeln(Book.title),
    write('Author\'s: '),
    writeln(Book.author_name).

getMostReadSubject(MostReadSubject) :-
    controllers_books:indexBooks(Books),
    foldl(concatenateBooks, Books, [], Subjects),
    msort(Subjects, SList),
    rle(SList, RLE),
    sort(RLE, SRLE),
    last(SRLE, [Freq, MostReadSubject]).

concatenateBooks(CurrentBook, Previous, Result) :-
    writeln(CurrentBook),
    append(Previous, CurrentBook.subject, Result).

count_repeated([Elem|Xs], Elem, Count, Ys) :-
    count_repeated(Xs, Elem, Count1, Ys), Count is Count1+1.
count_repeated([AnotherElem|Ys], Elem, 0, [AnotherElem|Ys]) :-
    Elem \= AnotherElem.
count_repeated([], _, 0, []).

rle([X|Xs], [[C,X]|Ys]) :-
    count_repeated([X|Xs], X, C, Zs),
    rle(Zs, Ys).
rle([], []).