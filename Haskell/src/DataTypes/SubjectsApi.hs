{-# LANGUAGE DeriveGeneric #-}

module DataTypes.Api where

import Data.Aeson
import GHC.Generics

data BookSubjectsResponse = BookSubjectsResponse
  { title :: String,
    subject :: [String],
    author_name :: [String]
  }
  deriving (Eq, Generic)

instance ToJSON BookSubjectsResponse where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON BookSubjectsResponse

newtype SubjectsResponse = SubjectsResponse {works :: [BookSubjectsResponse]}
  deriving (Eq, Generic)

instance ToJSON SubjectsResponse where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON SubjectsResponse