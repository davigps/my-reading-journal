module Screens.Main where

import DataTypes.Api
import Screens.Books
import Utils.Screen

mainMenuDisplay :: IO String
mainMenuDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nMy Reading Journal\n=-=-=-=-=-=-=-=-=-=\n\
      \a) Adicionar livro\nb) Editar livro\nc) Listar livros\nd) Excluir livro\n\
      \Sua opção: "
  mainMenuOptions line

mainMenuOptions :: String -> IO String
mainMenuOptions option
  | option == "a" = addBookDisplay
  | option == "b" = editBookDisplay
  | option == "c" = seeBooksDisplay
  | option == "d" = delBookDisplay
  | otherwise = exitMenuDisplay

exitMenuDisplay :: IO String
exitMenuDisplay = do
  return ""