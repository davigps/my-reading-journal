{-# LANGUAGE DeriveGeneric #-}

module DataTypes.Application where

import Data.Aeson
import Data.Time.Calendar
import GHC.Generics

data Book = Book
  { title :: String,
    subject :: [String],
    author_name :: [String],
    rate :: Int,
    description :: String
  }
  deriving (Eq, Generic)

instance ToJSON Book where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON Book
