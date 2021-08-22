module Screens.SearchBook where

import DataTypes.Api
import Utils.Api
import Utils.Screen

searchBookDisplay :: String -> Int -> IO String
searchBookDisplay bookTitle page = do
  books <- searchBook bookTitle page
  printBooks books 1

  putOnScreen "Aperte Enter para continuar"

printBooks :: [BookApi] -> Int -> IO ()
printBooks [] index = return ()
printBooks (current : rest) index = do
  putStrLn $ getBookString current index
  printBooks rest (index + 1)

getBookString :: BookApi -> Int -> String
getBookString book index =
  ".................\n"
    ++ "-- Option "
    ++ show index
    ++ "\n"
    ++ show book
