{-# LANGUAGE DeriveGeneric #-}
module Main where

import GHC.Generics
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BL
import DSL.Sensor
import DSL.Action
import DSL.Rule
import DSL.Validator

data Input = Input
    { sensors :: [Sensor]
    , actions :: [Action]
    , rules :: [Rule]
    } deriving (Show, Generic)

instance FromJSON Input

data Result = Result
    { ok :: Bool
    , error :: Maybe String
    } deriving (Show, Generic)

instance ToJSON Result

main :: IO ()
main = do
    bs <- BL.getContents
    case eitherDecode bs of
        Left e -> BL.putStrLn (encode (Result False (Just e)))
        Right (Input ss as rs) ->
            case validate (Config ss as rs) of
                Left err -> BL.putStrLn (encode (Result False (Just (show err))))
                Right () -> BL.putStrLn (encode (Result True Nothing))

