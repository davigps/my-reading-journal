module Utils.Api where

import Data.Aeson (decode)
import DataTypes.Api
import qualified DataTypes.Subjects as Subjects
import Network.HTTP.Base (urlEncodeVars)
import Network.HTTP.Conduit (simpleHttp)
import qualified Network.URI.Encode as URI

makeRequest :: String -> Int -> IO (Maybe SearchResponse)
makeRequest bookTitle page =
  fmap decode $
    simpleHttp $
      "http://openlibrary.org/search.json?limit=5&"
        ++ urlEncodeVars [("q", bookTitle), ("page", show page)]

searchBook :: String -> Int -> IO ([BookApi], Int)
searchBook bookTitle page = do
  (Just response) <- makeRequest bookTitle page
  let books = map cleanBook (docs response)
  let totalPages = num_found response `div` 5
  return (books, totalPages)

cleanBook :: BookApi -> BookApi
cleanBook book = BookApi (title book) (cleanSubjects (subject book)) (author_name book)

cleanSubjects :: [String] -> [String]
cleanSubjects = filter (`elem` Subjects.subjects)

makeSubjectsRequest :: String -> IO (Maybe Subjects.SubjectsResponse)
makeSubjectsRequest subjectName =
  fmap decode $
    simpleHttp $
      "http://openlibrary.org/"
        ++ URI.encode subjectName
        ++ ".json"

searchSubject :: String -> IO [Subjects.BookSubjectsResponse]
searchSubject bookTitle = do
  (Just response) <- makeSubjectsRequest bookTitle
  return $ Subjects.works response
