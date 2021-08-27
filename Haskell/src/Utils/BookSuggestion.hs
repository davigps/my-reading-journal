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

getBestRatedSubject :: [Book] -> String
getBestRatedSubject books = onlySubjects !! bestRatedIndex
  where
    allSubjects = map subject books
    onlySubjects = concat allSubjects
    rateList = map (`getSubjectRate` books) onlySubjects
    maybeIndex = elemIndex (maximum rateList) rateList
    bestRatedIndex = fromMaybe 0 maybeIndex

getSubjectRate :: String -> [Book] -> Int
getSubjectRate sub books = getTotalSumRate sub books `div` length books
  where
    getTotalSumRate sub [] = 0
    getTotalSumRate sub (current : rest) =
      if sub `elem` subject current
        then rate current + getTotalSumRate sub rest
        else getTotalSumRate sub rest
