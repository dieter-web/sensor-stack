-- DSL/Action.hs
{-# LANGUAGE DeriveGeneric #-}
module DSL.Action where

import GHC.Generics
import Data.Aeson
import Data.Text (Text)

data Action = Action
    { id :: Text
    , type_ :: Text
    , pin :: Int
    , value :: Int
    } deriving (Show, Generic)

instance FromJSON Action where
    parseJSON = genericParseJSON defaultOptions { fieldLabelModifier = fix }
        where fix "type_" = "type"; fix x = x
