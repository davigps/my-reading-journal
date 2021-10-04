:- module(controllers_profile, []).

:- use_module("./src/utils/files.pl", []).
:- use_module("./src/controllers/books.pl").

indexProfile(Profile):-
  utils_files:get_dict_from_json_file("./data/profile.json", Profile).

getCurrentGoal(Sum):-
  controllers_books:indexBooks(Books),
  length_l(X,Books), Sum is X.

length_l(0,[]).
length_l(L+1, [_|T]) :- length_l(L,T).

updateProfile(Profile):-
  utils_files:save_dict_to_json_file("./data/profile.json", _{
  'currentGoal':'0',
  'currentTarget': Profile
}).