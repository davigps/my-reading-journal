:- module(utils_api, []).
:- encoding(utf8).

:- use_module(library(http/http_open)).
:- use_module(library(http/json)).

searchBook(ApiBooks) :-
    setup_call_cleanup(
        http_open('http://openlibrary.org/search.json?limit=5&q=harry', In, [request_header('Accept'='application/json')]),
        json_read_dict(In, ApiBooks),
        close(In)
    ).
