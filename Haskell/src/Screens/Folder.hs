module Screens.Folder where

import Utils.Screen

enterFolderDisplay :: IO String
enterFolderDisplay = do
  putOnScreenCls "\n=-=-=-=-=-=-=-=-=-=\nList Folders\n=-=-=-=-=-=-=-=-=-=\n"
  -- Listar as pastas
  line <- putOnScreen "Digite o nome da Pasta: "
  return line