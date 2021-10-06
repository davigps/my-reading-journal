:- module(utils_books, [rateValidation/2, categories/1, checkLength/2]).
:- encoding(utf8).

:- use_module("./src/utils/books.pl").

:- use_module("./src/controllers/books.pl").

checkLength(Num, Books):-
    Num >= 1,
    length(Books, BooksSize),
    Num =< BooksSize.

rateValidation(Rate, NewRate):-
    (10 < Rate;Rate < 0),
    writeln('Invalid rate. The rate must be from 0 to 10. Try again.'),
    read_line_to_string(user_input, NewRate),
    number_string(NewRateInt, NewRate),
    rateValidation(NewRateInt, _).
rateValidation(Rate, Rate).

displayBooks:-
    controllers_books:indexBooks(Books),
    utils_books:printBooks(Books, 1).

displayFilteredBooks(Folder):-
    controllers_books:indexBooks(Books),
    exclude(folderToFilter(Folder), Books, PrintBooks),
    utils_filter:searchOption(PrintBooks, FilteredBooks),
    utils_books:printBooks(FilteredBooks, 1).

folderToFilter(Folder, Book) :-
    Folder \= Book.folder.

printBooks([], _).
printBooks([Book|Tail], Option):-
    write("\n"),  
    writeln("---------------------"),
    atom_concat('-- Option ', Option, OptionNumber),
    writeln(OptionNumber),
    atom_concat('Title: ', Book.title, Title),
    atom_concat('Rate: ', Book.rate, Rate),
    atom_concat('Description: ', Book.description, Description),
    atom_concat('Registration Date: ', Book.dateNow, Date),
    writeln(Title),
    write('Subjects: '),
    writeln(Book.subject),
    write('Author\'s: '),
    writeln(Book.author_name),
    writeln(Rate),
    writeln(Description),
    writeln(Date),
    NextOption is Option + 1,
    printBooks(Tail, NextOption).

printApiBooks([], _).
printApiBooks([Book|Tail], Option):-
    write("\n"),  
    writeln("---------------------"),
    atom_concat('-- Option ', Option, OptionNumber),
    writeln(OptionNumber),
    atom_concat('Title: ', Book.title, Title),
    writeln(Title),
    write('Author\'s name: '),
    writeln(Book.author_name),
    write('Subjects: '),
    writeln(Book.subject),
    NextOption is Option + 1,
    printApiBooks(Tail, NextOption).

deleteBook(Books, Index):-
    nth1(Index, Books, ResponseBook),
    controllers_books:deleteBook(ResponseBook.title).

getCurrentDateString(DateString) :-
    date(date(Year, Month, Day)),
    atom_concat(Day, '/', DayString),
    atom_concat(Month, '/', MonthString),
    atom_concat(MonthString, Year, YearString),
    atom_concat(DayString, YearString, DateString).

categories(["Arts",
    "Architecture",
    "Art Instruction",
    "Art History",
    "Dance",
    "Design",
    "Fashion",
    "Film",
    "Graphic Design",
    "Music",
    "Music Theory",
    "Painting",
    "Photography",
    "Animals",
    "Bears",
    "Cats",
    "Kittens",
    "Dogs",
    "Puppies",
    "Fiction",
    "Fantasy",
    "Historical Fiction",
    "Horror",
    "Humor",
    "Literature",
    "Magic",
    "Mystery and detective stories",
    "Plays",
    "Poetry",
    "Romance",
    "Science Fiction",
    "Short Stories",
    "Thriller",
    "Young Adult",
    "Science & Mathematics",
    "Biology",
    "Chemistry",
    "Mathematics",
    "Physics",
    "Programming",
    "Business & Finance",
    "Management",
    "Entrepreneurship",
    "Business Economics",
    "Business Success",
    "Finance",
    "Children's",
    "Kids Books",
    "Stories in Rhyme",
    "Baby Books",
    "Bedtime Books",
    "Picture Books",
    "History",
    "Ancient Civilization",
    "Archaeology",
    "Anthropology",
    "World War II",
    "Social Life and Customs",
    "Health & Wellness",
    "Cooking",
    "Cookbooks",
    "Mental Health",
    "Exercise",
    "Nutrition",
    "Self-help",
    "Biography",
    "Autobiographies",
    "History",
    "Politics and Government",
    "World War II",
    "Women",
    "Kings and Rulers",
    "Composers",
    "Artists",
    "Social Sciences",
    "Anthropology",
    "Religion",
    "Political Science",
    "Psychology",
    "Places",
    "Brazil",
    "India",
    "Indonesia",
    "United States",
    "Textbooks",
    "History",
    "Mathematics",
    "Geography",
    "Psychology",
    "Algebra",
    "Education",
    "Business & Economics",
    "Science",
    "Chemistry",
    "English Language",
    "Physics",
    "Computer Science",
    "Other"]).    