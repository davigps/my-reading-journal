module Controllers.Profile where
    
import DataTypes.Profile
import qualified Data.ByteString.Lazy as BL
import Data.Aeson
import Controllers.Book

profileJSON = "data/profile.json"

indexProfile :: IO Profile
indexProfile = do
  (Just profile) <- decode <$> BL.readFile profileJSON :: IO (Maybe Profile)
  return profile

deleteProfile :: IO Bool
deleteProfile = do
  BL.writeFile profileJSON $ encode ""; return True

createProfile :: Profile -> IO Bool
createProfile newProfile = do
  deleteProfile
  BL.writeFile profileJSON $ encode newProfile; return True
  

updateProfile :: Profile -> IO Bool
updateProfile newProfile = do
  deleteProfile 
  createProfile newProfile

updateGoal :: IO Bool 
updateGoal = do
  profile <- indexProfile
  books <- indexBooks
  let newGoal = length books
  let newProfile = Profile newGoal (currentTarget profile) 
  deleteProfile
  createProfile newProfile