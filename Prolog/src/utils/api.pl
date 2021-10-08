:- module(utils_api, []).
:- encoding(utf8).

:- use_module('./src/utils/books.pl').

:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(url)).
:- use_module(library(uri)).

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
    dict_keys(OldBook, Keys),
    (member(subject, Keys) -> Subject = OldBook.subject; Subject = ["Other"]),
    (member(author_name, Keys) -> Authors = OldBook.author_name; Authors = ['Unknown']),
    exclude(isNormalizedSubject, Subject, NewSubjects),
    writeln(NewSubjects),
    NewBook = _{
        'title': OldBook.title,
        'author_name': Authors,
        'subject': NewSubjects
    }.

isNormalizedSubject(Subject) :-
    utils_books:categories(AllCategories),
    not(member(Subject, AllCategories)).

requestSearchSubject(BookSubject, Response) :-
    uri_encoded(path, BookSubject, EncodedBookSubject),
    atom_concat('/subjects/', EncodedBookSubject, SubjectEncoded),
    atom_concat(SubjectEncoded, '.json', PathEncoded),
    Attributes = [ 
        protocol(http),
        host('openlibrary.org'),
        path(PathEncoded)
    ],
    parse_url(Url, Attributes),
    setup_call_cleanup(
        http_open(Url, In, [request_header('Accept'='application/json')]),
        json_read_dict(In, Response),
        close(In)
    ).
