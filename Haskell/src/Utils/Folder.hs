module Utils.Folder where

import Controllers.Book
import qualified Data.Set as Set
import DataTypes.Application

indexFolders :: IO [String]
indexFolders = map folder <$> indexBooks

cleanFolders :: [String] -> [String]
cleanFolders folders = Set.elems $ Set.fromList folders

showFolder :: String -> Int -> IO ()
showFolder folder index = putStr $ "\n-------------\n" ++ show index ++ ") " ++ folder

printFolders :: [String] -> Int -> IO ()
printFolders [] n = return ()
printFolders (current : rest) index = do
  showFolder current index
  printFolders rest (index + 1)

getFolderBooks :: [Book] -> String -> [Book]
getFolderBooks books folderName = filter (\book -> folder book == folderName) books
