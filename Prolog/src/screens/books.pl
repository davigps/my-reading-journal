:- module(screens_books, [screen/1]).
:- encoding(utf8).

:- use_module("./src/screens/main.pl", []).
:- use_module("./src/screens/searchBook.pl", []).

:- use_module("./src/utils/files.pl").
:- use_module("./src/utils/books.pl").
:- use_module("./src/utils/bookSuggestion.pl").
:- use_module("./src/utils/screens.pl").
:- use_module("./src/utils/folders.pl").

:- use_module("./src/controllers/profile.pl").
:- use_module("./src/controllers/books.pl").

screen('add_book'):-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nAdd book\n=-=-=-=-=-=-=-=-=-=\n\c
        Enter the name of the book or "v" to go back:'),
    read_line_to_string(user_input, Name),
    (Name == "v" -> screens_main:screen('start'); 
        screens_searchBook:screen('search_book', Name, 1)).

screen('edit_book'):-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nEdit book\n=-=-=-=-=-=-=-=-=-=\n'),
    controllers_books:indexBooks(Books),
    utils_books:printBooks(Books, 1),
    writeln('\nChoose an option or digit "v" to go back:'),
    %utils_books:displayBooks,
    %writeln('\nChoose an option or digit "v" to go back:'),
    read_line_to_string(user_input, Choice),
    editOption(Choice, Books).

screen('delete_books'):-
    utils_screens:cls,
    write('\n=-=-=-=-=-=-=-=-=-=\nDelete book\n=-=-=-=-=-=-=-=-=-=\n'),
    controllers_books:indexBooks(Books),
    utils_books:printBooks(Books, 1),
    writeln('\nChoose an option or digit "v" to go back:'),
    read_line_to_string(user_input, Choice),
    deleteOption(Choice, Books).

screen('edit_goal'):-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nEdit reading goal\n=-=-=-=-=-=-=-=-=-=\n'),
    writeln('\nEnter new goal or \'v\' to go back:'),
    read_line_to_string(user_input, Choice),
    editGoalOption(Choice).

screen('list_books'):-
    utils_screens:cls,
    write('\n=-=-=-=-=-=-=-=-=-=\nList book\n=-=-=-=-=-=-=-=-=-=\n'),
    controllers_folders:indexFolders(Folders),
    utils_folders:printFolders(Folders, 1),
    writeln('\n Choice the folder or press \'a\' to list all books.'),
    read_line_to_string(user_input, Choice),
    (Choice == "a" -> screen('all_books'); screen('filtered_books', Choice)),
    utils_screens:waitInput.

screen('all_books'):-
    utils_screens:cls,
    write('\n=-=-=-=-=-=-=-=-=-=\nList book\n=-=-=-=-=-=-=-=-=-=\n'),
    utils_books:displayBooks.

screen('book_suggestion'):-
    utils_screens:cls,
    write('\n=-=-=-=-=-=-=-=-=-=\nReading Suggestion\n=-=-=-=-=-=-=-=-=-=\n'),
    writeln('Based on your readings and ratings:\n'),
    utils_bookSuggestion:suggestionBooks,
    utils_screens:waitInput.

screen('filtered_books', Choice):-
    utils_screens:cls,
    utils_folders:getFolderBooks(Choice, Folder),
    write('\n=-=-=-=-=-=-=-=-=-=\nList book\n=-=-=-=-=-=-=-=-=-=\n'),
    utils_books:displayFilteredBooks(Folder).

editOption("v", _):-
    main:screen('start').
editOption(Choice, Books):-
    number_string(Num, Choice),
    %Num >= 1,
    %Num =< 5, % Trocar pelo length
    writeln('Enter the new rate: '),
    read_line_to_string(user_input, NewRate),
    number_string(RateInt, NewRate),
    utils_books:rateValidation(RateInt, Rate),
    writeln('Enter the new description: '),
    read_line_to_string(user_input, NewDescription),
    nth1(Num, Books, ResponseBook),
    NewBook = _{
        'author_name': ResponseBook.author_name,
        'dateNow': ResponseBook.dateNow,
        'description': NewDescription,
        'folder': ResponseBook.folder,
        'rate': Rate,
        'subject': ResponseBook.subject,
        'title': ResponseBook.title
    },
    controllers_books:updateBook(ResponseBook.title, NewBook),
    writeln('\nYour book has been successfully edited!'),
    utils_screens:waitInput.
editOption(_, _):-
    writeln('Invalid option! Try again.'),
    read_line_to_string(user_input, NewChoice),
    editOption(NewChoice).

deleteOption("v", _):-
    main:screen('start').
deleteOption(Choice, Books):-
    number_string(Num, Choice),
    %Num >= 1,
    %Num =< 5, % Trocar pelo length
    utils_books:deleteBook(Books, Num),
    writeln('Your book has been successfully deleted!'),
    utils_screens:waitInput.

deleteOption(_, _):-
    writeln('Invalid option! Try again.'),
    read_line_to_string(user_input, NewChoice),
    deleteOption(NewChoice, _).

editGoalOption("v"):-
    main:screen('start').
editGoalOption(Choice):-
    number_string(NumChoice, Choice),
    integer(NumChoice),
    controllers_profile:updateProfile(Choice),
    writeln('Your goal has been successfully changed!').
editGoalOption(_):-
    writeln('Invalid option! Try again.'),
    read_line_to_string(user_input, NewChoice),
    editGoalOption(NewChoice).