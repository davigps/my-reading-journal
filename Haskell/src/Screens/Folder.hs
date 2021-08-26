module Screens.Folder where

import Controllers.Book
import Data.List
import Data.Maybe
import DataTypes.Application
import Utils.Screen

enterFolderDisplay :: IO String
enterFolderDisplay = do
  clearScreen
  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nFolders\n=-=-=-=-=-=-=-=-=-=\n"

  folders <- indexFolders
  printFolders folders 1
  let foldersLength = show $ length folders

  let message =
        "\n\n=-=-=-=-=-=-=-=-=-=\n\
        \Enter the option number (1..."
          ++ foldersLength
          ++ ")\nor 'c' to cancel\n\
             \or 'a' to add new folder\nYour choice:"

  line <- putOnScreen message
  enterFolderOptions line folders

enterFolderOptions :: String -> [String] -> IO String
enterFolderOptions option folders
  | option == "c" = return ""
  | option == "a" = createFolderDisplay
  | optionNumber `elem` [1 .. foldersLength] = return chooseFolder
  | otherwise = do
    putOnScreen "Invalid option! (Press ENTER to continue)"
    enterFolderDisplay
  where
    optionNumber = read option :: Int
    foldersLength = length folders
    chooseFolder = folders !! (optionNumber -1)

indexFolders :: IO [String]
indexFolders = map folder <$> indexBooks

showFolder :: String -> Int -> IO ()
showFolder folder index = putStr $ "\n-------------\n" ++ show index ++ ") " ++ folder

printFolders :: [String] -> Int -> IO ()
printFolders [] n = return ()
printFolders (current : rest) index = do
  showFolder current index
  printFolders rest (index + 1)

createFolderDisplay :: IO String
createFolderDisplay = putOnScreenCls "\n=-=-=-=-=-=-=-=-=-=\nCreate Folder\n=-=-=-=-=-=-=-=-=-=\nEnter new folder's name: "
