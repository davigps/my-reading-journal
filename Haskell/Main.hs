import Screens.Main
import Utils.Screen

loop :: IO String -> IO ()
loop screen = do
  let nextScreen = screen
  stringScreen <- nextScreen
  putStr stringScreen
  if null stringScreen then return () else loop nextScreen

main = do
  loop mainMenuDisplay