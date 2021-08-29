{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module DataTypes.Api where

import Data.Aeson
import Data.Maybe
import GHC.Generics

data BookApi = BookApi
  { title :: String,
    subject :: [String],
    author_name :: [String]
  }
  deriving (Eq)

instance Show BookApi where
  show (BookApi title subject author_name) =
    "Title: "
      ++ title
      ++ "\n\
         \Subjects: "
      ++ show subject
      ++ "\n\
         \Author's name: "
      ++ show author_name

instance FromJSON BookApi where
  parseJSON = withObject "Book" $ \obj -> do
    t <- obj .: "title"
    a <- obj .:? "author_name"
    s <- obj .:? "subject"

    let justSubject = fromMaybe ["Other"] s
    let justAuthors = fromMaybe ["Other"] a

    return (BookApi {title = t, subject = justSubject, author_name = justAuthors})

data SearchResponse = SearchResponse {docs :: [BookApi], num_found :: Int}
  deriving (Eq, Generic)

instance FromJSON SearchResponse
