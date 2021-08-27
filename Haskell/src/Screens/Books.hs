module Screens.Books where

import Controllers.Book
import Controllers.Profile
import DataTypes.Application
import DataTypes.Profile
import Screens.Folder
import Screens.SearchBook
import Utils.Screen

addBookDisplay :: IO String
addBookDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nAdd book\n=-=-=-=-=-=-=-=-=-=\n\
      \Enter the name of the book or 'v' to go back:"

  if line == "v"
    then return ""
    else searchBookDisplay line 1

editBookDisplay :: IO String
editBookDisplay = do
  clearScreen
  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nEdit book\n=-=-=-=-=-=-=-=-=-=\n"
  books <- indexBooks
  printBooks books 1

  line <-
    putOnScreen
      "\nChoose an option or digit 'v' to go back:"


  if line == "v"
    then return ""
    else do
      let optionNumber = read line :: Int
      if optionNumber `elem` [1 .. length books]
        then do
          let bookTitle = title $ books !! (optionNumber -1)
          (Just book) <- readBook bookTitle
          enterEditDetails book
          return ""
        else do
          putOnScreen "Invalid option! (Press ENTER to continue)"
          editBookDisplay

enterEditDetails :: Book -> IO String
enterEditDetails book = do
  newRate <- putOnScreen "Enter the new rate: "
  let intRate = read newRate :: Int
  if intRate > 10 || intRate < 0
    then do
      putOnScreen "Invalid rate. The rate must be from 0 to 10. (Press ENTER to continue)"
      enterEditDetails book
    else do
      newDescription <- putOnScreen "Enter the new description: "

      let rateInt = read newRate :: Int
      let newBook = Book (title book) (subject book) (author_name book) rateInt newDescription (folder book) (dateNow book)
      updateBook (title book) newBook

      putOnScreen "Your book has been successfully edited! (Press ENTER to continue)"
      return ""

seeBooksDisplay :: IO String
seeBooksDisplay = do
  clearScreen
  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nList Books\n=-=-=-=-=-=-=-=-=-=\n"
  books <- chooseFolderDisplay
  if books /= []
    then do
      clearScreen
      putStrLn "\n=-=-=-=-=-=-=-=-=-=\nList Books\n=-=-=-=-=-=-=-=-=-=\n"
      printBooks books 1
      putOnScreen "\n\n(Press ENTER to continue)"
      return ""
    else do
      return ""

delBookDisplay :: IO String
delBookDisplay = do
  clearScreen
  putStrLn
    "\n=-=-=-=-=-=-=-=-=-=\nDelete book\n=-=-=-=-=-=-=-=-=-=\n"
  books <- indexBooks
  printBooks books 1

  line <-
    putOnScreen
      "\nChoose an option or digit 'v' to go back:"

  if line == "v"
    then return ""
    else do
      let optionNumber = read line :: Int
      if optionNumber `elem` [1 .. length books]
        then do
          let bookTitle = title $ books !! (optionNumber -1)

          successDelete <- deleteBook bookTitle

          putOnScreen "Your book has been successfully deleted! (Press ENTER to continue)"
          updateGoal
          return ""
        else do
          putOnScreen "Invalid option! (Press ENTER to continue)"
          delBookDisplay

editBookGoalDisplay :: IO String
editBookGoalDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nEdit reading goal\n=-=-=-=-=-=-=-=-=-=\n\
      \Enter new goal or 'v' to go back:"
  if line == "v"
    then return ""
    else do
      let target = read line :: Int
      books <- indexBooks
      let goal = length books
      let newProfile = Profile goal target
      updateProfile newProfile
      putOnScreen "Your goal has been successfully changed! (Press ENTER to continue)"
      return ""

suggestionDisplay :: IO String
suggestionDisplay = do
  putOnScreenCls
    "\n=-=-=-=-=-=-=-=-=-=\nReading Suggestion\n=-=-=-=-=-=-=-=-=-=\n\
    \Based on your readings and ratings: Harry Potter\n\n\
    \(Press ENTER to continue)"
  return ""