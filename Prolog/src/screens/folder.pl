:- module(screens_folder, [screen/1]).
:- encoding(utf8).

:- use_module("./src/screens/main.pl", []).

:- use_module("./src/utils/screens.pl").
:- use_module("./src/utils/folders.pl").

:- use_module("./src/controllers/folders.pl").

screen('add_folder', CreatedFolder):-
    utils_screens:cls,
    writeln('\n=-=-=-=-=-=-=-=-=-=\nCreate Folder\n=-=-=-=-=-=-=-=-=-=\nEnter new folder\'s name: '),
    read_line_to_string(user_input, CreatedFolder),
    controllers_folders:createFolder(CreatedFolder).

screen('list_folders'):-
    utils_screens:cls,
    write('\n=-=-=-=-=-=-=-=-=-=\nList Folders\n=-=-=-=-=-=-=-=-=-=\n'),
    controllers_folders:indexFolders(Folders),
    utils_folders:printFolders(Folders, 1).

indexBooks(Books) :-
    utils_files:get_dict_from_json_file("./data/books.json", BooksFile),
    Books = BooksFile.get('books').