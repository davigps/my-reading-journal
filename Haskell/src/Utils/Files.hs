module Utils.Files where

import Data.Aeson
import qualified Data.ByteString.Lazy as BL
import DataTypes.Application

booksJSON = "data/books.json"

fetchBooks :: IO [Book]
fetchBooks = do
  (Just allBooks) <- decode <$> BL.readFile booksJSON :: IO (Maybe [Book])
  return allBooks

noBooksYet :: IO Bool
noBooksYet = null <$> fetchBooks

saveBook :: Book -> IO Bool
saveBook newBook = do
  allBooks <- fetchBooks
  let correspondingBooks = filter (\book -> title book == title newBook) allBooks
  if null correspondingBooks
    then do BL.writeFile booksJSON $ encode (newBook : allBooks); return True
    else return False

updateBook :: String -> Book -> IO Bool
updateBook bookTitle newBook = do
  deleteBook bookTitle
  saveBook newBook

deleteBook :: String -> IO Bool
deleteBook bookTitle = do
  allBooks <- fetchBooks
  let removed = filter (\book -> title book /= bookTitle) allBooks
  if allBooks /= removed
    then do BL.writeFile booksJSON $ encode removed; return True
    else return False
