:- module(controllers_folders, []).

:- use_module("./src/utils/files.pl", []).
:- use_module(library(apply)).

indexFolders(Folders) :-
    utils_files:get_dict_from_json_file("./data/folders.json", FoldersFile),
    Folders = FoldersFile.get('folders').

createFolder(Folder) :-
    indexFolders(SavedFolders),
    append(SavedFolders, [Folder], ResultFolders),
    utils_files:save_dict_to_json_file("./data/folders.json", _{
        'folders': ResultFolders
    }).
