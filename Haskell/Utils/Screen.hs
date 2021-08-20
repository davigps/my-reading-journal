module Utils.Screen where

putOnScreen :: String -> IO String
putOnScreen output = do
  putStr output
  getLine
