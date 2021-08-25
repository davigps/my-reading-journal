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

instance Show Book where
  show (Book title subject author_name rate description) =
    "Title: "
      ++ title
      ++ "\n\
         \Subjects: "
      ++ show subject
      ++ "\n\
         \Author's name: "
      ++ show author_name
      ++ "\n\
         \Rate: "
      ++ show rate
      ++ "\n\
         \Description: "
      ++ description

instance ToJSON Book where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON Book
