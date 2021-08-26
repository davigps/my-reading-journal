module Screens.Folder where

import Controllers.Book
import DataTypes.Application
import Utils.Folder
import Utils.Screen

enterFolderDisplay :: IO String
enterFolderDisplay = do
  clearScreen
  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nFolders\n=-=-=-=-=-=-=-=-=-=\n"

  folders <- indexFolders
  let foldersSet = cleanFolders folders
  printFolders foldersSet 1
  let foldersLength = show $ length foldersSet

  let message =
        "\n\n=-=-=-=-=-=-=-=-=-=\n\
        \Enter the option number (1..."
          ++ foldersLength
          ++ ")\nor 'c' to cancel\n\
             \or 'a' to add new folder\nYour choice:"

  line <- putOnScreen message
  enterFolderOptions line foldersSet

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

createFolderDisplay :: IO String
createFolderDisplay = putOnScreenCls "\n=-=-=-=-=-=-=-=-=-=\nCreate Folder\n=-=-=-=-=-=-=-=-=-=\nEnter new folder's name: "

chooseFolderDisplay :: IO [Book]
chooseFolderDisplay = do
  clearScreen
  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nFolders\n=-=-=-=-=-=-=-=-=-=\n"

  folders <- indexFolders
  let foldersSet = cleanFolders folders
  printFolders foldersSet 1
  let foldersLength = show $ length foldersSet

  let message =
        "\n\n=-=-=-=-=-=-=-=-=-=\n\
        \Enter the option number (1..."
          ++ foldersLength
          ++ ")\nor 'c' to cancel\nYour choice:"

  line <- putOnScreen message
  chooseFolderOptions line foldersSet

chooseFolderOptions :: String -> [String] -> IO [Book]
chooseFolderOptions option folders
  | option == "c" = return []
  | optionNumber `elem` [1 .. foldersLength] = do
    books <- indexBooks
    return $ getFolderBooks books chooseFolder
  | otherwise = do
    putOnScreen "Invalid option! (Press ENTER to continue)"
    chooseFolderDisplay
  where
    optionNumber = read option :: Int
    foldersLength = length folders
    chooseFolder = folders !! (optionNumber -1)
