module Screens.SearchBook where

import Data.Char (digitToInt)
import DataTypes.Api
import qualified DataTypes.Application
import Utils.Api
import Utils.Files
import Utils.Screen

searchBookDisplay :: String -> Int -> IO String
searchBookDisplay bookTitle page = do
  putStrLn "Loading..."
  books <- searchBook bookTitle page
  clearScreen

  putStrLn "\n=-=-=-=-=-=-=-=-=-=\nSearch Results\n=-=-=-=-=-=-=-=-=-=\n"
  printBooks books 1
  line <-
    putOnScreen
      "\n\n=-=-=-=-=-=-=-=-=-=\n\
      \Enter the option number (1...5) \n\
      \or 'c' to cancel\n\
      \or 'n' to see next page\n\
      \or 'p' to see previous page\n\
      \Your choice:"

  searchBookOptions books bookTitle page line

searchBookOptions :: [BookApi] -> String -> Int -> String -> IO String
searchBookOptions books bookTitle page option
  | option == "c" = return ""
  | option == "n" = searchBookDisplay bookTitle (page + 1)
  | option == "p" = searchBookDisplay bookTitle (page - 1)
  | otherwise = do
    let optionNumber = digitToInt $ head option
    enterDetailsDisplay (books !! optionNumber)

printBooks :: [BookApi] -> Int -> IO ()
printBooks [] index = return ()
printBooks (current : rest) index = do
  putStrLn $ getBookString current index
  printBooks rest (index + 1)

getBookString :: BookApi -> Int -> String
getBookString book index =
  "\n---------------------\n"
    ++ "-- Option "
    ++ show index
    ++ "\n"
    ++ show book

enterDetailsDisplay :: BookApi -> IO String
enterDetailsDisplay bookApi = do
  rate <- putOnScreen "Enter a rate for the book: "
  description <- putOnScreen "Enter a description for the book: "

  saveBook
    ( DataTypes.Application.Book
        (title bookApi)
        (subject bookApi)
        (author_name bookApi)
        (digitToInt (head rate))
        description
    )

  putOnScreen "Your book has been successfully added! (Press ENTER to continue)"
  return ""
