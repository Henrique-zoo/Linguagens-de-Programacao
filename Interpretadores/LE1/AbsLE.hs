-- File generated by the BNF Converter (bnfc 2.9.5).

-- | The abstract syntax of language LE1.

module AbsLE where

import Prelude (Integer)
import qualified Prelude as C (Eq, Ord, Show, Read)

data Exp
    = EAdd Exp Exp
    | ESub Exp Exp
    | EMul Exp Exp
    | EDiv Exp Exp
    | EInt Integer
  deriving (C.Eq, C.Ord, C.Show, C.Read)