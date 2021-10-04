:- module(utils_api, []).
:- encoding(utf8).

:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(url)).

searchBook(BookTitle, Page, ApiBooks) :-
    Attributes = [ 
        protocol(http),
        host('openlibrary.org'),
        path('/search.json'),
        search([ 
          limit = '5',
          q = BookTitle,
          page = Page
        ])
    ],
    parse_url(Url, Attributes),
    setup_call_cleanup(
        http_open(Url, In, [request_header('Accept'='application/json')]),
        json_read_dict(In, ApiBooks),
        close(In)
    ).
