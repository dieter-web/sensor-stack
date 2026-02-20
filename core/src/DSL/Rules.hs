-- DSL/Rule.hs
{-# LANGUAGE DeriveGeneric #-}
module DSL.Rule where

import GHC.Generics
import Data.Aeson
import Data.Text (Text)

data Rule = Rule
    { id :: Text
    , when :: Text
    , action :: Text
    } deriving(Show, Generic)

instance FromJSON Rule

