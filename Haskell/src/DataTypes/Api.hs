{-# LANGUAGE DeriveGeneric #-}

module DataTypes.Api where

import Data.Aeson
import GHC.Generics

data BookApi = BookApi
  { title :: String,
    subject :: [String],
    author_name :: [String]
  }
  deriving (Eq, Generic)

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

instance ToJSON BookApi where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON BookApi

data SearchResponse = SearchResponse {docs :: [BookApi], num_found :: Int}
  deriving (Eq, Generic)

instance ToJSON SearchResponse where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON SearchResponse
