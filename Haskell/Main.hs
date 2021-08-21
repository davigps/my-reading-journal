import Screens.Main
import Utils.Screen

loop :: IO String -> IO ()
loop screen = do
  let nextScreen = screen
  stringScreen <- nextScreen
  if null stringScreen then return () else loop nextScreen
  loop screen

main = do
  loop mainMenuDisplay
