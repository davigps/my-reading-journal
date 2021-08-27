module Utils.BookSuggestion where

import Controllers.Book
import Data.List
import Data.Maybe
import DataTypes.Application

getMostReadSubject :: [Book] -> String
getMostReadSubject books = onlySubjects !! mostReadIndex
  where
    allSubjects = map subject books
    onlySubjects = concat allSubjects
    frequencyList = map (`getFrequencyItem` onlySubjects) onlySubjects
    maybeIndex = elemIndex (maximum frequencyList) frequencyList
    mostReadIndex = fromMaybe 0 maybeIndex

getFrequencyItem :: String -> [String] -> Int
getFrequencyItem item [] = 0
getFrequencyItem item (current : rest) =
  if item == current
    then 1 + getFrequencyItem item rest
    else getFrequencyItem item rest
