module Testes.TestesQ2 where

import Questoes.Q2.AbsLI
    ( Exp(EVar, EStr, ECon, EFalse, ETrue, EOr, EAnd, ENot),
      Ident(Ident),
      Program(..),
      Stm(SAss, SBlock)
    )
import Questoes.Q2.Interpreter
    ( executeP, Valor(ValorBool, ValorStr) )

prog1 :: Program
prog1 = Prog (SBlock [ SAss (Ident "w") (EStr "hello"), SAss (Ident "v") (EStr "world"), SAss (Ident "a") (ECon (EVar (Ident "w")) (EVar (Ident "v")))])

{-

{
    w = "hello";
    v = "world";
    a = w ++ v;
}

-}

-- executeP :: RContext -> Program  -> RContext
testCase1 :: Bool
testCase1 = executeP [] prog1 == [("w", ValorStr "hello"), ("v", ValorStr "world"), ("a", ValorStr "helloworld")]

-----------------------------------------------------------------------------------------------------------------------

prog2 :: Program
prog2 = Prog (SBlock [SAss (Ident "a") ETrue, SAss (Ident "b") EFalse, SAss (Ident "e") ETrue, SAss (Ident "d") (EOr (ENot (EVar (Ident "a"))) (EAnd (EVar (Ident "b")) (EVar (Ident "e")))), SAss (Ident "f") (EOr (EAnd (EVar (Ident "a")) (EVar (Ident "b"))) (ENot (EVar (Ident "e"))))])

{--

{
    a = true;
    b = false;
    e = true;
    d = ! a || b && e;
    f = a && b || ! e;
}

--}

testCase2 :: Bool
testCase2 = executeP [] prog2 == [("a", ValorBool True), ("b", ValorBool False), ("e", ValorBool True), ("d", ValorBool False), ("f", ValorBool False)]

-- Uma condicao necessária (mas não suficiente) da implementação eh que o valor de testSuite seja "True"
testSuite :: Bool
testSuite = testCase1 && testCase2

--------------------- VERIFICAÇÃO DOS TESTES ---------------------

main :: IO()
main = do
    putStr ("O resultado do primeiro teste foi: " ++ show testCase1)
    putStr ("O resultado do segundo teste foi: " ++ show testCase2)
    putStr ("O resultado geral foi: " ++ show testSuite)