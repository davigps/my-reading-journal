:- module(controllers_books, []).

:- use_module("./src/utils/files.pl", []).


indexBooks(Books) :-
    utils_files:get_dict_from_json_file("./data/books.json", Books).
