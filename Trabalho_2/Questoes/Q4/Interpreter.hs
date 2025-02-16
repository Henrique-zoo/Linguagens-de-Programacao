module Questoes.Q4.Interpreter where

import Questoes.Q4.AbsLI (Exp(..), Stm(..), Program(..), Ident(..))
import Prelude hiding (lookup)

type RContext = [(String, Integer)]
type ErrorMessage = String

-- Função principal para executar o programa
executeP :: RContext -> Program -> Either ErrorMessage RContext
executeP context (Prog stm) = execute context stm

-- Função para executar um comando (Stm)
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
                        Left errorMessage -> Left errorMessage
                        Right newContext -> execute newContext (SWhile exp stm)
                else Right context

    STry [] _ stmsFinally -> execute context (SBlock stmsFinally)
    STry (s : stmsTry) stmsCatch stmsFinally ->
        case execute context s of
            Left _ -> execute context (SBlock (stmsCatch ++ stmsFinally))
            Right newContext -> execute newContext (STry stmsTry stmsCatch stmsFinally)

-- Função para avaliar expressões
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

-- Função para extrair o nome da variável (Ident)
getStr :: Ident -> String
getStr (Ident s) = s

-- Função para buscar o valor de uma variável no contexto
lookup :: RContext -> String -> Integer
lookup ((i, v) : cs) s
    | i == s = v
    | otherwise = lookup cs s

-- Função para atualizar o valor de uma variável no contexto
update :: RContext -> String -> Integer -> RContext
update [] s v = [(s, v)]
update ((i, v) : cs) s nv
    | i == s = (i, nv) : cs
    | otherwise = (i, v) : update cs s nv