module Utils.Screen where

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
