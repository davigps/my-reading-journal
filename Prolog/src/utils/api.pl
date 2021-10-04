:- module(utils_api, []).
:- encoding(utf8).

:- use_module('./src/utils/books.pl').

:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(url)).

requestSearchBook(BookTitle, Page, ApiBooks) :-
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

searchBook(BookTitle, Page, ApiBooks) :-
    requestSearchBook(BookTitle, Page, Response),
    maplist(filterBookSubjects, Response.docs, ApiBooks).

filterBookSubjects(OldBook, NewBook) :-
    exclude(isNormalizedSubject, OldBook.subject, NewSubjects),
    writeln(NewSubjects),
    NewBook = _{
        'title': OldBook.title,
        'author_name': OldBook.author_name,
        'subject': NewSubjects
    }.

isNormalizedSubject(Subject) :-
    utils_books:categories(AllCategories),
    not(member(Subject, AllCategories)).
