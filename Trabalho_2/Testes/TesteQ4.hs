module Testes.TestesQ4 where

import Questoes.Q4.AbsLI
    ( Exp(EInt, EAdd, ESub, EDiv, EVar),
      Ident(Ident),
      Program(Prog),
      Stm(SAss, SWhile, SBlock, STry)
    )
import Questoes.Q4.Interpreter ( executeP )

prog1 :: Program
prog1 = Prog (SBlock [SAss (Ident "x") (EInt 1), SAss (Ident "soma") (EInt 0), SAss (Ident "c") (EInt 10), SWhile (EVar (Ident "c")) (SBlock [SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))), SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))])])

{--

{
    x = 1;
    soma = 0;
    c = 10;
    while (c) {
        soma = soma + c;
        c = c - 1;
    }
}

--}

testCase1 :: Bool
testCase1 = executeP [] prog1 == Right [("x", 1), ("soma", 55), ("c", 0)]

-----------------------------------------------------------------------------------------------------------------------

prog2 :: Program
prog2 = Prog (SBlock [SAss (Ident "x") (EInt 0), STry [SAss (Ident "soma") (EInt 0), SAss (Ident "c") (EDiv (EVar (Ident "x")) (EVar (Ident "soma")))] [SAss (Ident "x") (EInt 1)] [SAss (Ident "y") (EInt 2)]])

{-

{
    x = 0;
    try {
        soma = 0;
        c = x / soma;
    } catch {
        x = 1;
    } finally {
        y = 2;
    }
}

-}

-- executeP :: RContext -> Program  -> RContext
testCase2 :: Bool
testCase2 = executeP [] prog2 == Right [("x", 1), ("soma", 0), ("y", 2)]

-----------------------------------------------------------------------------------------------------------------------

prog3 :: Program
prog3 = Prog (SBlock [ SAss (Ident "x") (EInt 0), STry [SAss (Ident "soma") (EInt 10), SAss (Ident "c") (EDiv (EVar (Ident "x")) (EVar (Ident "soma")))] [SAss (Ident "x") (EInt 1)] [SAss (Ident "y") (EInt 2)]])

{-

{
    x = 0;
    try {
        soma = 10;
        c = x / soma;
    } catch {
        x = 1;
    } finally {
        y = 2;
    }
}

-}

testCase3 :: Bool
testCase3 = executeP [] prog3 == Right [("x", 0), ("soma", 10), ("c", 0), ("y", 2)]

-- Uma condição necessária (mas não suficiente) da implementação é que o valor de testSuite seja "True"
testSuite :: Bool
testSuite = testCase1 && testCase2 && testCase3

main :: IO()
main = do
    putStr ("O resultado do primeiro teste foi: " ++ show testCase1)
    putStr ("O resultado do segundo teste foi: " ++ show testCase2)
    putStr ("O resultado do terceiro teste foi: " ++ show testCase3)
    putStr ("O resultado geral dos testes: " ++ show testSuite)