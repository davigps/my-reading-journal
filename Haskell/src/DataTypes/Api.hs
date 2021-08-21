{-# LANGUAGE DeriveGeneric #-}

module DataTypes.Api where

import Data.Aeson
import GHC.Generics

data BookApi = BookApi
  { title :: String,
    subject :: [String],
    author_name :: [String]
  }
  deriving (Generic, Show)

newtype SearchResponse = SearchResponse {docs :: [BookApi]}

instance ToJSON BookApi where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON BookApi
