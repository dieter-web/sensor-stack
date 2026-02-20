module DSL.Validator where

import DSL.Sensor
import DSL.Action
import DSL.Rule
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Set as S

data Config = Config
    { sensors :: [Sensor]
    , actions :: [Action]
    , rules :: [Rule]
    } deriving (Show)

data ValidationError
    = DuplicateSensor Text
    | DuplicateAction Text
    | UnknownAction Text
    | UnknownSensorInRule Text
    deriving (Show)

validate :: Config -> Either ValidationError()
validate cfg = do
    let sIds = map DSL.Sensor.id(sensors cfg)
        aIds = map DSL.Action.id(actions cfg)
    checkDup DuplicateSensor sIds
    checkDup DuplicateAction aIds
    mapM_ (checkRule sIds aIds) (rules cfg)

checkDup :: (Text -> ValidationError) -> [Text] -> Either ValidationError ()
checkDup mk xs =
    let s = S.fromList xs
    in if length xs == S.size s then Right() else Left (mk "duplicate")

checkRule :: [Text] -> [Text] -> Rule -> Either ValidationError ()
checkRule sIds aIds r = do
    if action r `elem` aIds then pure () else Left (UnknownAction (action r))
    let sid = head (T.words (when r)) -- "temp1 > 25"
    if sid `elem` sIds then pure () else Left (UnknownSensorInRule sid)

