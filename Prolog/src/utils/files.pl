:- module(utils_files, [get_dict_from_json_file/2, save_dict_to_json_file/2]).
:- encoding(utf8).

:- use_module(library(http/json)).

get_dict_from_json_file(FPath, Dicty) :-
    open(FPath, read, Stream), json_read_dict(Stream, Dicty), close(Stream).

save_dict_to_json_file(FPath, Dicty) :-
    open(FPath, write, Stream), json_write_dict(Stream, Dicty), close(Stream).
