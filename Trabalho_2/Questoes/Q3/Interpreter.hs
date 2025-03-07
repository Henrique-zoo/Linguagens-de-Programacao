module Questoes.Q3.Interpreter where

import Questoes.Q3.AbsLI (Exp(..), Stm(..), Program(..), Ident(..))
import Prelude hiding (lookup)

type RContext = [(String, Integer)]
type ErrorMessage = String

executeP :: RContext -> Program -> Either ErrorMessage RContext
executeP context (Prog stm) = execute context stm

execute :: RContext -> Stm -> Either ErrorMessage RContext
execute context x = case x of
    SAss id exp ->
        case eval context exp of
            Left errorMessage -> Left errorMessage
            Right evalExp -> Right (update context (getStr id) evalExp)

    SBlock [] -> Right context
    SBlock (s : stms) ->
        case execute context s of
            Left errorMessage -> Left errorMessage
            Right newContext -> execute newContext (SBlock stms)

    SWhile exp stm ->
        case eval context exp of
            Left errorMessage -> Left errorMessage
            Right evalExp ->
                if evalExp /= 0 then
                    case execute context stm of
                        Right newContext -> execute newContext (SWhile exp stm)
                        Left errorMessage -> Left errorMessage
                else Right context

eval :: RContext -> Exp -> Either ErrorMessage Integer
eval context x = case x of
    EAdd exp0 exp ->
        case eval context exp0 of
            Left errorMessage -> Left errorMessage
            Right evalExp0 ->
                case eval context exp of
                    Left errorMessage -> Left errorMessage
                    Right evalExp -> Right (evalExp0 + evalExp)

    ESub exp0 exp ->
        case eval context exp0 of
            Left errorMessage -> Left errorMessage
            Right evalExp0 ->
                case eval context exp of
                    Left errorMessage -> Left errorMessage
                    Right evalExp -> Right (evalExp0 - evalExp)

    EMul exp0 exp ->
        case eval context exp0 of
            Left errorMessage -> Left errorMessage
            Right evalExp0 ->
                case eval context exp of
                    Left errorMessage -> Left errorMessage
                    Right evalExp -> Right (evalExp0 * evalExp)

    EDiv exp0 exp ->
        case eval context exp0 of
            Left errorMessage -> Left errorMessage
            Right evalExp0 ->
                case eval context exp of
                    Left errorMessage -> Left errorMessage
                    Right evalExp ->
                        if evalExp == 0 then Left "divisao por 0"
                        else Right (evalExp0 `div` evalExp)

    EInt n -> Right n
    EVar id -> Right (lookup context (getStr id))

getStr :: Ident -> String
getStr (Ident s) = s

lookup :: RContext -> String -> Integer
lookup ((i, v) : cs) s
    | i == s = v
    | otherwise = lookup cs s

update :: RContext -> String -> Integer -> RContext
update [] s v = [(s, v)]
update ((i, v) : cs) s nv
    | i == s = (i, nv) : cs
    | otherwise = (i, v) : update cs s nv