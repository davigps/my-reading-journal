module DataTypes.Api where

data BookApi = BookApi
  { title :: String,
    subject :: [String],
    author_name :: String
  }

newtype SearchResponse = SearchResponse {docs :: [BookApi]}
