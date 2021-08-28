module Utils.BookSuggestion where

import Controllers.Book
import Data.List
import Data.Maybe
import Data.Time.Clock.POSIX
import DataTypes.Application
import qualified DataTypes.Subjects as Subjects
import System.Random

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

isAlreadyRegistered :: String -> [Book] -> Bool
isAlreadyRegistered bookTitle books = not (null filteredBooks)
  where
    filteredBooks = filter (\book -> title book == bookTitle) books

onlyBooksFromSubject :: [Subjects.BookSubjectsResponse] -> String -> [Subjects.BookSubjectsResponse]
onlyBooksFromSubject books sub = filter (\book -> sub `elem` Subjects.subject book) books

getRandomUnreadBook :: [Subjects.BookSubjectsResponse] -> IO Subjects.BookSubjectsResponse
getRandomUnreadBook books = do
  savedBooks <- indexBooks
  book <- randomBookFromList books
  if isAlreadyRegistered (Subjects.title book) savedBooks
    then getRandomUnreadBook books
    else return book

randomBookFromList :: [Subjects.BookSubjectsResponse] -> IO Subjects.BookSubjectsResponse
randomBookFromList books = do
  bookIndex <- getRandomIndex
  return $ books !! bookIndex
  where
    getTime = round `fmap` getPOSIXTime :: IO Int
    seed time = mkStdGen time
    getRandomIndex = do
      let n = length books
      time <- getTime
      let currentSeed = seed time
      let (rand, _) = randomR (0, n -1) currentSeed
      return rand
