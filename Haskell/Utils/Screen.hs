module Utils.Screen where

import System.Info
import System.Process

putOnScreen :: String -> IO String
putOnScreen output = do
  -- if os == "linux" then system "clear" else system "cls"
  putStr output
  getLine
