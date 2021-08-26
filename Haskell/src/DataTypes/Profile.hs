{-# LANGUAGE DeriveGeneric #-}

module DataTypes.Profile where

import Data.Aeson
import Data.Time.Calendar
import GHC.Generics

data Profile = Profile
  { currentGoal :: Int,
    currentTarget :: Int
  }
  deriving (Eq, Generic)

instance Show Profile where
  show (Profile currentGoal currentTarget) =
    "Goal: " ++ 
      show currentGoal ++ 
      "/" ++ 
      show currentTarget ++
      " books\n\n" 

instance ToJSON Profile where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON Profile
