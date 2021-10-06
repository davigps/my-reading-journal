:- module(utils_filter, []).
:- encoding(utf8).

:- use_module("./src/controllers/books.pl").

:- use_module(library(lists)).

searchOption(FilteredBooks):-
    controllers_books:indexBooks(AllBooks),
    searchOption(FilteredBooks, AllBooks).

searchOption(FilteredBooks, Books):-
    writeln("Would you like to filter books? \'y\' or \'n\'."),
    read_line_to_string(user_input, Choice),
    searchBooks(Choice, FilteredBooks, Books).

searchBooks("n", FilteredBooks, Books):-
    FilteredBooks = Books.
searchBooks("y", FilteredBooks, Books):-
    utils_screens:cls,
    writeln("\n1 - Max Rate \n2 - Min Rate \n3 - Author \n4 - Subject"),
    read_line_to_string(user_input, Choice),
    number_string(Num, Choice),
    Num >= 1,
    Num =< 4,
    filter(Num, FilteredBooks, Books).

filter(1, FilteredBooks, Books):-
    utils_screens:cls,
    writeln("Rate: "),
    read_line_to_string(user_input, Choice),
    number_string(Num, Choice),
    exclude(maxRate(Num), Books, FilteredBooks).

filter(2, FilteredBooks, Books):-
    utils_screens:cls,
    writeln("Rate: "),
    read_line_to_string(user_input, Choice),
    number_string(Num, Choice),
    exclude(minRate(Num), Books, FilteredBooks).

filter(3, FilteredBooks, Books):-
    utils_screens:cls,
    writeln("Author: "),
    read_line_to_string(user_input, Choice),
    exclude(author(Choice), Books, FilteredBooks).

filter(4, FilteredBooks, Books):-
    utils_screens:cls,
    writeln("Subject: "),
    read_line_to_string(user_input, Choice),
    exclude(subject(Choice), Books, FilteredBooks).

maxRate(Rate, Book):-
    Rate < Book.rate.

minRate(Rate, Book):-
    Rate > Book.rate.

author(Name, Book):-
    \+ member(Name, Book.author_name).

subject(Name, Book):-
    \+ member(Name, Book.subject).