module Controllers.Book where

import Data.Aeson
import qualified Data.ByteString.Lazy as BL
import DataTypes.Application
import Data.Char

booksJSON = "data/books.json"

indexBooks :: IO [Book]
indexBooks = do
  (Just allBooks) <- decode <$> BL.readFile booksJSON :: IO (Maybe [Book])
  return allBooks

noBooksYet :: IO Bool
noBooksYet = null <$> indexBooks

createBook :: Book -> IO Bool
createBook newBook = do
  allBooks <- indexBooks
  let correspondingBooks = filter (\book -> map toLower (title book) == map toLower (title newBook)) allBooks
  if null correspondingBooks
    then do BL.writeFile booksJSON $ encode (newBook : allBooks); return True
    else return False

readBook :: String -> IO (Maybe Book)
readBook bookTitle = do
  allBooks <- indexBooks
  let corresponding = filter (\book -> map toLower (title book) == map toLower bookTitle) allBooks
  if null corresponding
    then return Nothing
    else return $ Just (head corresponding)

updateBook :: String -> Book -> IO Bool
updateBook bookTitle newBook = do
  deleteBook bookTitle
  createBook newBook

deleteBook :: String -> IO Bool
deleteBook bookTitle = do
  allBooks <- indexBooks
  let removed = filter (\book -> map toLower (title book) /= map toLower bookTitle) allBooks
  if allBooks /= removed
    then do BL.writeFile booksJSON $ encode removed; return True
    else return False