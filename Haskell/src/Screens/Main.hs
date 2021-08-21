module Screens.Main where

import DataTypes.Api
import Screens.Books
import System.Exit
import Utils.Screen

mainMenuDisplay :: IO String
mainMenuDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nMy Reading Journal\n=-=-=-=-=-=-=-=-=-=\n\
      \a) Adicionar livro\nb) Editar livro\nc) Listar livros\nd) Excluir livro\ne) Sair\n\
      \Sua opção: "
  mainMenuOptions line

mainMenuOptions :: String -> IO String
mainMenuOptions option
  | option == "a" = addBookDisplay
  | option == "b" = editBookDisplay
  | option == "c" = seeBooksDisplay
  | option == "d" = delBookDisplay
  | option == "e" = exitSuccess
  | otherwise = do
    putOnScreen "Opção invalida. Aperte enter para continuar."
    mainMenuDisplay
