module Screens.Folder where

import Utils.Screen

enterFolderDisplay :: IO String
enterFolderDisplay = do
  line <- putOnScreenCls "\n=-=-=-=-=-=-=-=-=-=\nFolders\n=-=-=-=-=-=-=-=-=-=\nDigite o nome da Pasta: "
  putStrLn "\n"
  return line