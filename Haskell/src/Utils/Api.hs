module Utils.Api where

import Data.Aeson (decode)
import DataTypes.Api (BookApi, SearchResponse (docs))
import Network.HTTP.Base (urlEncodeVars)
import Network.HTTP.Conduit (simpleHttp)

makeRequest :: String -> Int -> IO (Maybe SearchResponse)
makeRequest bookTitle page =
  fmap decode $
    simpleHttp $
      "http://openlibrary.org/search.json?limit=5&"
        ++ urlEncodeVars [("q", bookTitle), ("page", show page)]

searchBook :: String -> Int -> IO [BookApi]
searchBook bookTitle page = do
  (Just response) <- makeRequest bookTitle page
  return $ docs response