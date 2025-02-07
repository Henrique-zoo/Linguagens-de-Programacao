module Questoes.Q5.Interpreter where

import Questoes.Q5.AbsLI
import Prelude hiding (lookup)

type RContext = [(String, Valor)]
type ErrorMessage = String
data Valor
    = ValorStr String
    | ValorInt Integer
    | ValorBool Bool

instance Eq Valor where
    (ValorInt i1) == (ValorInt i2) = i1 == i2
    (ValorStr s1) == (ValorStr s2) = s1 == s2
    (ValorBool b1) == (ValorBool b2) = b1 == b2

s :: Valor -> String
s (ValorStr str) = str

i :: Valor -> Integer
i (ValorInt vint) = vint

b :: Valor -> Bool
b (ValorBool vbool) = vbool

executeP :: RContext -> Program -> Either ErrorMessage RContext
executeP context (Prog stm) = execute context stm

execute :: RContext -> Stm -> Either ErrorMessage RContext
execute context x = case x of
    SAss id exp -> case eval context exp of
        Left errorMessage -> Left errorMessage
        Right evalExp -> Right (update context (getStr id) evalExp)
    SBlock [] -> Right context
    SBlock (s : stms) -> case execute context s of
        Left errorMessage -> Left errorMessage
        Right newContext -> execute newContext (SBlock stms)
    SWhile exp stm -> case eval context exp of
        Left errorMessage -> Left errorMessage
        Right (ValorInt evalExp) ->
            if evalExp /= 0 then
                case execute context stm of
                    Right newContext -> execute newContext (SWhile exp stm)
                    Left errorMessage -> Left errorMessage
            else Right context
        Right (ValorBool evalExp) ->
            if evalExp then
                case execute context stm of
                    Right newContext -> execute newContext (SWhile exp stm)
                    Left errorMessage -> Left errorMessage
            else Right context
    SdoWhile stm exp -> case execute context stm of
        Left errorMessage -> Left errorMessage
        Right newContext -> execute newContext (SWhile exp stm)
    STry [] _ stmsFinally -> execute context (SBlock stmsFinally)
    STry (s : stmsTry) stmsCatch stmsFinally -> case execute context s of
        Left _ -> execute context (SBlock (stmsCatch ++ stmsFinally))
        Right newContext -> execute newContext (STry stmsTry stmsCatch stmsFinally)

eval :: RContext -> Exp -> Either ErrorMessage Valor
eval context x = case x of
    EAdd exp0 exp -> case eval context exp0 of
        Left errorMessage -> Left errorMessage
        Right evalExp0 -> case eval context exp of
            Left errorMessage -> Left errorMessage
            Right evalExp -> Right (ValorInt (i evalExp0 + i evalExp))
    ESub exp0 exp -> case eval context exp0 of
        Left errorMessage -> Left errorMessage
        Right evalExp0 -> case eval context exp of
            Left errorMessage -> Left errorMessage
            Right evalExp ->  Right (ValorInt (i evalExp0 - i evalExp))
    EMul exp0 exp -> case eval context exp0 of
        Left errorMessage -> Left errorMessage
        Right evalExp0 -> case eval context exp of
            Left errorMessage -> Left errorMessage
            Right evalExp -> Right (ValorInt (i evalExp0 * i evalExp))
    EDiv exp0 exp -> case eval context exp0 of
        Left errorMessage -> Left errorMessage
        Right evalExp0 -> case eval context exp of
            Left errorMessage -> Left errorMessage
            Right evalExp ->
                if i evalExp == 0 then
                    Left "divisao por 0"
                else Right (ValorInt (i evalExp0 `div` i evalExp))
    ECon exp0 exp -> case eval context exp0 of
        Right evalExp0 -> case eval context exp of
            Right evalExp -> Right (ValorStr (s evalExp0 ++ s evalExp))
    EInt n -> Right (ValorInt n)
    EVar id -> Right (lookup context (getStr id))
    EStr str -> Right (ValorStr str)
    EOr exp0 exp -> case eval context exp0 of
        Right evalExp0 -> case eval context exp of
            Right evalExp -> Right (ValorBool (b evalExp0 || b evalExp))
    EAnd exp0 exp -> case eval context exp0 of
        Right evalExp0 -> case eval context exp of
            Right evalExp -> Right (ValorBool (b evalExp0 && b evalExp))
    ENot exp -> case eval context exp of
        Right evalExp -> Right (ValorBool (not (b evalExp)))
    ETrue -> Right (ValorBool True)
    EFalse -> Right (ValorBool False)

getStr :: Ident -> String
getStr (Ident s) = s

lookup :: RContext -> String -> Valor
lookup ((i, v) : cs) s
    | i == s = v
    | otherwise = lookup cs s

update :: RContext -> String -> Valor -> RContext
update [] s v = [(s, v)]
update ((i, v) : cs) s nv
    | i == s = (i, nv) : cs
    | otherwise = (i, v) : update cs s nv
