module Utils.Screen where

putOnScreen :: String -> IO Int
putOnScreen output = do
  putStr output
  line <- getLine
  let answer = read line :: Int
  return answer
