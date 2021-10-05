:- module(utils_bookSuggestion, []).
:- encoding(utf8).

:- use_module("./src/utils/api.pl").
:- use_module("./src/utils/screens.pl").

:- use_module("./src/controllers/books.pl").

suggestionBooks:-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nLoading\n=-=-=-=-=-=-=-=-=-=\n'),
    getMostReadSubject(MostReadSubject),
    getBestRatedSubject(BestRatedSubject),
    utils_api:requestSearchSubject(BestRatedSubject, Response),
    exclude(isNotFromSubject(MostReadSubject), Response.works, FilteredBooks),
    unreadRandomBook(FilteredBooks, Book),
    maplist(getAuthorName, Book.authors, Authors),
    utils_screens:cls,
    write('Title: '),
    writeln(Book.title),
    write('Author\'s name: '),
    writeln(Authors).

getMostReadSubject(MostReadSubject) :-
    controllers_books:indexBooks(Books),
    foldl(concatenateSubjects, Books, [], Subjects),
    msort(Subjects, SList),
    rle(SList, RLE),
    sort(RLE, SRLE),
    last(SRLE, [_, MostReadSubject]).

getBestRatedSubject(BestRatedSubject) :-
    controllers_books:indexBooks(Books),
    foldl(concatenateSubjects, Books, [], Subjects),
    list_to_set(Subjects, SubjectsSet),
    maplist(getSubjectRate, SubjectsSet, SubjectRates),
    max_member(@=<, MaxRate, SubjectRates),
    indexOf(SubjectRates, MaxRate, MaxIndex),
    nth0(MaxIndex, SubjectsSet, BestRatedSubject).
    
getSubjectRate(Subject, Rate) :-
    controllers_books:indexBooks(Books),
    exclude(isNotFromSubject(Subject), Books, FilteredBooks),
    maplist(getBookRate, FilteredBooks, Rates),
    sum_list(Rates, RateTotal),
    length(Rates, RatesLength),
    Rate is RateTotal / RatesLength.
    
getBookRate(Book, Book.rate).

isNotFromSubject(Subject, Book) :-
    not(member(Subject, Book.subject)).

concatenateSubjects(CurrentBook, Previous, Result) :-
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

indexOf([Element|_], Element, 0):- !.
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1),
  !,
  Index is Index1+1.

unreadRandomBook(List, Elem) :-
    length(List, Length),
    random_between(0, Length, Index), !,
    nth1(Index, List, RandomElem),
    controllers_books:indexBooks(Books),
    exclude(controllers_books:booksAreNotIdentical(RandomElem.title), Books, Search),
    length(Search, SearchSize),
    (SearchSize =:= 0 -> Elem = RandomElem; unreadRandomBook(List, Elem)).

getAuthorName(Author, Author.name).
