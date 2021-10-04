:- module(screens_searchBook, [screen/3]).
:- encoding(utf8).

:- use_module("./src/utils/api.pl").
:- use_module("./src/utils/screens.pl").
:- use_module("./src/utils/books.pl").
:- use_module("./src/utils/screens.pl").

:- use_module("./src/screens/main.pl", []).
:- use_module("./src/screens/folder.pl", []).

screen('search_book', Name, Page):-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nLoading\n=-=-=-=-=-=-=-=-=-=\n'),
    utils_api:searchBook(Name, Page, Response),
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nSearch Results\n=-=-=-=-=-=-=-=-=-=\n'),
    utils_books:printApiBooks(Response, 1),
    write('\n'),
    writeln('Enter the option number (1...5)\n\c
        or "c" to cancel\n\c
        or "n" to see next page\n\c
        or "p" to see previous page\n\c
        Your choice:\n'),
    read_line_to_string(user_input, Choice),
    searchBookOption(Choice, Name, Page, Response).

searchBookOption("c", _, _, _):- screens_main:screen('start').
searchBookOption("n", Name, Page, _):- % Verificar a quantidade máxima de páginas
    NewPage is Page + 1,
    screen('search_book', Name, NewPage).
searchBookOption("p", Name, Page, _):- 
    NewPage is Page - 1,
    (Page =:= 1 -> screen('search_book', Name, Page);
        screen('search_book', Name, NewPage)).
searchBookOption(NumString, _, _, Books):-
    number_string(Num, NumString),
    Num >= 1,
    length(Books, BooksSize),
    Num =< BooksSize, 
    nth1(Num, Books, ChosenBook),
    writeln('Opção escolhida'),
    enterDetailsDisplay(ChosenBook),
    utils_screens:waitInput.
searchBookOption(_, Name, Page, _):-
    writeln('Invalid option! Try again.'),
    read_line_to_string(user_input, Choice),
    searchBookOption(Choice, Name, Page).

enterDetailsDisplay(BookApi):-
    utils_books:getCurrentDateString(DateString),
    writeln('Enter a rate for the book: '),
    read_line_to_string(user_input, RateString),
    number_string(RateInt, RateString),
    utils_books:rateValidation(RateInt, Rate),
    writeln('Enter a description for the book: '),
    read_line_to_string(user_input, Description),
    screens_folder:screen('list_folders'),
    write("\n"),
    writeln('You need to choose a folder or press c to create!'),
    read_line_to_string(user_input, Choose),
    createBook(_{
        'title': BookApi.title,
        'subject': BookApi.subject,
        'author_name': BookApi.author_name,
        'rate': Rate,
        'description': Description,
        'dateNow': DateString
    }, Choose).

createBook(Book, "c") :-
    screens_folder:screen('add_folder', CreatedFolder),
    CreatedBook = Book.put('folder', CreatedFolder),
    controllers_books:createBook(CreatedBook).
createBook(Book, Choose) :-
    utils_folders:getFolderBooks(Choose, Folder),
    CreatedBook = Book.put('folder', Folder),
    controllers_books:createBook(CreatedBook).
