module Utils.Screen where

import DataTypes.Application
import System.Info
import System.Process

clearScreen =
  if os == "linux" then system "clear" else system "cls"

putOnScreenCls :: String -> IO String
putOnScreenCls output = do
  clearScreen
  putStrLn output
  getLine

putOnScreen :: String -> IO String
putOnScreen output = do
  putStrLn output
  getLine

printBooks :: [Book] -> Int -> IO ()
printBooks [] index = return ()
printBooks (current : rest) index = do
  putStrLn $ getBookString current index
  printBooks rest (index + 1)

getBookString :: Book -> Int -> String
getBookString book index =
  "\n---------------------\n"
    ++ "-- Option "
    ++ show index
    ++ "\n"
    ++ show book
