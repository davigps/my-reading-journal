module Screens.SearchBook where

import Controllers.Book
import Controllers.Profile
import Data.Char (digitToInt)
import Data.Time
  ( FormatTime,
    defaultTimeLocale,
    formatTime,
    getCurrentTime,
    getCurrentTimeZone,
    utcToLocalTime,
  )
import DataTypes.Api
import qualified DataTypes.Application
import Screens.Folder
import Utils.Api
import Utils.Screen

searchBookDisplay :: String -> Int -> IO String
searchBookDisplay bookTitle page = do
  clearScreen
  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nLoading...\n=-=-=-=-=-=-=-=-=-=\n"
  (books, totalPages) <- searchBook bookTitle page
  clearScreen

  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nSearch Results\n=-=-=-=-=-=-=-=-=-=\n"
  if null books
    then putOnScreen "Book not found! (Press ENTER to back)"
    else do
      printBookApis books 1
      line <-
        putOnScreen
          "\n\n=-=-=-=-=-=-=-=-=-=\n\
          \Enter the option number (1...5) \n\
          \or 'c' to cancel\n\
          \or 'n' to see next page\n\
          \or 'p' to see previous page\n\
          \Your choice:"

      searchBookOptions books totalPages bookTitle page line

searchBookOptions :: [BookApi] -> Int -> String -> Int -> String -> IO String
searchBookOptions books totalPages bookTitle page option
  | option == "c" = return ""
  | option == "n" = do
    if page == totalPages
      then do
        putOnScreen "Invalid option. (Press ENTER to continue)"
        searchBookDisplay bookTitle page
      else searchBookDisplay bookTitle (page + 1)
  | option == "p" = do
    if page /= 1
      then searchBookDisplay bookTitle (page - 1)
      else do
        putOnScreen "Invalid option. (Press ENTER to continue)"
        searchBookDisplay bookTitle page
  | (read option :: Int) `elem` [1 .. length books] = do
    let optionNumber = read option :: Int
    enterDetailsDisplay $ books !! (optionNumber - 1)
  | otherwise = do
    putOnScreen "Invalid option. (Press ENTER to continue)"
    searchBookDisplay bookTitle page

printBookApis :: [BookApi] -> Int -> IO ()
printBookApis [] index = return ()
printBookApis (current : rest) index = do
  putStrLn $ getBookApiString current index
  printBookApis rest (index + 1)

getBookApiString :: BookApi -> Int -> String
getBookApiString book index =
  "\n---------------------\n"
    ++ "-- Option "
    ++ show index
    ++ "\n"
    ++ show book

enterDetailsDisplay :: BookApi -> IO String
enterDetailsDisplay bookApi = do
  rate <- putOnScreen "Enter a rate for the book: "
  let intRate = read rate :: Int
  if 10 < intRate || intRate < 0
    then do
      putOnScreen "Invalid rate. The rate must be from 0 to 10. (Press ENTER to continue)"
      enterDetailsDisplay bookApi
    else do
      description <- putOnScreen "Enter a description for the book: "
      folder <- enterFolderDisplay

      t <- utcToLocalTime <$> getCurrentTimeZone <*> getCurrentTime
      let dateNow = unlines (formats <*> pure t)

      if null folder
        then do
          putOnScreen "You need to choose a folder! (Press ENTER to continue)"
          return ""
        else do
          createBook
            ( DataTypes.Application.Book
                (title bookApi)
                (subject bookApi)
                (author_name bookApi)
                (read rate :: Int)
                description
                folder
                dateNow
            )

          updateGoal
          putOnScreen "Your book has been successfully added! (Press ENTER to continue)"
          return ""

formats :: FormatTime t => [t -> String]
formats = formatTime defaultTimeLocale <$> ["%d %B, %Y"]