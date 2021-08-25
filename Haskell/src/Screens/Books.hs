module Screens.Books where

import Controllers.Book
import DataTypes.Application
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
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nEdit book\n=-=-=-=-=-=-=-=-=-=\n\
      \Enter the name of the book you want to edit or 'v' to go back:"

  (Just book) <- readBook line
  if line == "v"
    then return ""
    else do
      newRate <- putOnScreen "Enter the new rate: "
      newDescription <- putOnScreen "Enter the new description: "

      let rateInt = read newRate :: Int
      let newBook = Book (title book) (subject book) (author_name book) rateInt newDescription
      updateBook line newBook

      putOnScreen "Your book has been successfully edited! (Press ENTER to continue)"
      return ""

seeBooksDisplay :: IO String
seeBooksDisplay = do
  clearScreen
  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nList Books\n=-=-=-=-=-=-=-=-=-=\n"
  books <- indexBooks
  if books /= []
    then do
      printBooks books 1
      putOnScreen "\n\n(Press ENTER to continue)"
      return ""
    else do
      putOnScreen "There are no books here. (Press ENTER to continue)"
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
      "\nEscolha uma opção ou digite 'v' to go back:"
  
  if line == "v"
    then return ""
    else do
      let optionNumber = read line :: Int
      if elem optionNumber [1..5] 
        then do
          let bookTitle = title $ books !! (optionNumber-1)

          successDelete <- deleteBook bookTitle

          putOnScreen "Your book has been successfully deleted! (Press ENTER to continue)"
          return ""
        else do
          putOnScreen "Option Invalid! (Press ENTER to continue)"
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
      -- atualizar a nova meta
      putOnScreen "Your goal has been successfully changed! (Press ENTER to continue)"
      return ""

suggestionDisplay :: IO String
suggestionDisplay = do
  putOnScreenCls
    "\n=-=-=-=-=-=-=-=-=-=\nReading Suggestion\n=-=-=-=-=-=-=-=-=-=\n\
    \Based on your readings and ratings: Harry Potter\n\n\
    \(Press ENTER to continue)"
  return ""