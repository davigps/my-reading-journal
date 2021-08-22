module Controllers.Book where

import DataTypes.Application
import Utils.Files

createBook :: String -> [String] -> [String] -> Int -> String -> IO Bool
createBook bTitle bSuject bAuthor_name bRate bDescription =
  saveBook
    ( Book
        bTitle
        bSuject
        bAuthor_name
        bRate
        bDescription
    )
