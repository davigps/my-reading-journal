module Utils.Screen where

import System.Info
import System.Process

putOnScreenCls :: String -> IO String
putOnScreenCls output = do
  if os == "linux" then system "clear" else system "cls"
  putStr output
  getLine

putOnScreen :: String -> IO String
putOnScreen output = do
  putStr output
  getLine
