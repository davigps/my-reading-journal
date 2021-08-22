module Screens.Books where

import Screens.SearchBook
import Utils.Files
import Utils.Screen

addBookDisplay :: IO String
addBookDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nAdd book\n=-=-=-=-=-=-=-=-=-=\n\
      \Enter the name of the book or 'v' to go back:"
  -- Nome da obra
  -- Nome do autor
  -- Data de cadastro
  -- Gênero
  -- Nota
  -- Descrição
  if line == "v"
    then return ""
    else searchBookDisplay line 1

editBookDisplay :: IO String
editBookDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nEdit book\n=-=-=-=-=-=-=-=-=-=\n\
      \Enter the name of the book you want to edit or 'v' to go back:"

  if line == "v"
    then return ""
    else do
      rate <- putOnScreen "Enter the new rate: "
      description <- putOnScreen "Enter the new description: "
      --editBook line

      putOnScreen "Your book has been successfully edited! (Press ENTER to continue)"
      return ""

seeBooksDisplay :: IO String
seeBooksDisplay = do
  clearScreen
  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nList Books\n=-=-=-=-=-=-=-=-=-=\n"
  books <- fetchBooks
  printBooks books 1

  putOnScreen "\n\n(Press ENTER to continue)"
  return ""

delBookDisplay :: IO String
delBookDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nDelete book\n=-=-=-=-=-=-=-=-=-=\n\
      \Enter the name of the book you want to delete or 'v' to go back:"

  if line == "v"
    then return ""
    else do
      --deleteBook line
      -- response <- getApi "http://openlibrary.org/search.json?q=the+lord+of+the+rings&page=1&limit=2"
      -- putStrLn response

      putOnScreen "Your book has been successfully deleted! (Press ENTER to continue)"
      return ""

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