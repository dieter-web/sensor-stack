-- DSL/Sensor.hs
{-# LANGUAGE DeriveGeneric #-}
module DSL.Sensor where

import GHC.Generics
import Data.Aeson
import Data.Text (Text)

data Sensor = Sensor
    { id :: Text
    , type_ :: Text
    , driver :: Text
    , pin :: Int
    , interval :: Text
    } deriving(Show, Generic)

instance FromJSON Sensor where
    parseJSON = genericParseJSON defaultOptions { fieldLabelModifier = fix }
        where fix "type_" = "type"; fix x = x

