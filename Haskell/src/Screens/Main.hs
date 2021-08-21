module Screens.Main where

import DataTypes.Api
import Screens.Books
import System.Exit
import Utils.Screen

mainMenuDisplay :: IO String
mainMenuDisplay = do
  let currentGoal = 2
  let currentTarget = 10

  line <- putOnScreen 
    ("\n=-=-=-=-=-=-=-=-=-=\nMy Reading Journal\n=-=-=-=-=-=-=-=-=-=\n\n" ++
      "Meta: " ++ 
      show currentGoal ++ 
      "/" ++ 
      show currentTarget ++
      " livros\n\n" ++
      "1) Adicionar livro\n\
      \2) Editar livro\n\
      \3) Listar livros\n\
      \4) Excluir livro\n\
      \5) Editar meta\n\n\
      \6) Sair\n\n\n" ++
      "Sua opção: ")
  mainMenuOptions line

mainMenuOptions :: String -> IO String
mainMenuOptions option
  | option == "1" = addBookDisplay
  | option == "2" = editBookDisplay
  | option == "3" = seeBooksDisplay
  | option == "4" = delBookDisplay
  | option == "5" = editBookGoalDisplay
  | option == "6" = exitSuccess
  | otherwise = do
    putOnScreen "Opção invalida. Aperte enter para continuar."
    mainMenuDisplay
