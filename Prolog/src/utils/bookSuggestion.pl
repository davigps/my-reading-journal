:- module(utils_bookSuggestion, [rateValidation/2, categories/1]).
:- encoding(utf8).

:- use_module("./src/controllers/books.pl").

suggestionBooks:-
    %Fazer a parte lógica
    controllers_books:indexBooks([Book|_]),
    write('Title: '),
    writeln(Book.title),
    write('Author\'s: '),
    writeln(Book.author_name).
