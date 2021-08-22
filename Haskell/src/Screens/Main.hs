module Screens.Main where

import DataTypes.Api
import Screens.Books
import System.Exit
import Utils.Screen

mainMenuDisplay :: IO String
mainMenuDisplay = do
  let currentGoal = 2
  let currentTarget = 10

  line <- putOnScreenCls 
    ("\n=-=-=-=-=-=-=-=-=-=\nMy Reading Journal\n=-=-=-=-=-=-=-=-=-=\n\n" ++
      "Goal: " ++ 
      show currentGoal ++ 
      "/" ++ 
      show currentTarget ++
      " books\n\n" ++
      "1) Add books\n\
      \2) Edit books\n\
      \3) List books\n\
      \4) Delete books\n\
      \5) See book suggestion\n\
      \6) Edit reading goal\n\n\
      \7) Exit\n\n\n" ++
      "Your choice: ")
  mainMenuOptions line

mainMenuOptions :: String -> IO String
mainMenuOptions option
  | option == "1" = addBookDisplay
  | option == "2" = editBookDisplay
  | option == "3" = seeBooksDisplay
  | option == "4" = delBookDisplay
  | option == "5" = suggestionDisplay 
  | option == "6" = editBookGoalDisplay
  | option == "7" = exitSuccess
  | otherwise = do
    putOnScreen "Invalid option. Press ENTER to continue."
    mainMenuDisplay
