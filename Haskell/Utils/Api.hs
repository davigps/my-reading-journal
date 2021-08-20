module Utils.Api where

import Data.Aeson
import DataTypes.Api
import Network.HTTP

getApi :: String -> IO String
getApi url = simpleHTTP (getRequest url) >>= getResponseBody
