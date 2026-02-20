-- DSL/Expr.hs ( Stub für späteren Parser)
module DSL.Expr where

import Data.Text (Text)

data Expr
    = Greater Text Double
    | Less Text Double
    deriving (Show)

