module Controllers.Book where

import DataTypes.Application
import qualified Utils.Files

createBook :: String -> [String] -> [String] -> Int -> String -> IO Bool
createBook bTitle bSuject bAuthor_name bRate bDescription =
  Utils.Files.saveBook
    ( Book
        bTitle
        bSuject
        bAuthor_name
        bRate
        bDescription
    )

updateBook :: Book -> Int -> String -> IO Bool
updateBook book rate description =
  Utils.Files.updateBook (title book) newBook
  where
    newBook =
      Book
        (title book)
        (subject book)
        (author_name book)
        rate
        description