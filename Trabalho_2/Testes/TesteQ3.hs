module Testes.TestesQ3 where

import Questoes.Q3.AbsLI
    ( Exp(EInt, ESub, EDiv, EAdd, EVar),
      Ident(Ident),
      Program(Prog),
      Stm(SAss, SWhile, SBlock)
    )
import Questoes.Q3.Interpreter ( executeP )

prog1 :: Program
prog1 = Prog (SAss (Ident "x") (EInt 1))

{- prog1

x = 1;

-}

-- executeP :: RContext -> Program  -> RContext
testCase1 :: Bool
testCase1 = executeP [] prog1 == Right [("x", 1)]

-----------------------------------------------------------------------------------------------------------------------

prog2 :: Program
prog2 = Prog (SBlock [SAss (Ident "x") (EInt 1), SAss (Ident "soma") (EInt 0), SAss (Ident "c") (EInt 10), SWhile (EVar (Ident "c")) (SBlock [SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))), SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))])])

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

testCase2 :: Bool
testCase2 = executeP [] prog2 == Right [("x", 1), ("soma", 55), ("c", 0)]

-----------------------------------------------------------------------------------------------------------------------

{--

{
    x = 1;
    y = 0;
    z = x / y;
    w = z + 1;
}

--}

prog3 :: Program
prog3 = Prog (SBlock [SAss (Ident "x") (EInt 1), SAss (Ident "y") (EInt 0), SAss (Ident "z") (EDiv (EVar (Ident "x")) (EVar (Ident "y"))), SAss (Ident "w") (EAdd (EVar (Ident "z")) (EInt 1))])

testCase3 :: Bool
testCase3 = executeP [] prog3 == Left "divisao por 0"

-- uma condicao necessaria (mas nao suficiente) da implementacao eh que o valor de testSuite seja "True"
testSuite :: Bool
testSuite = testCase1 && testCase2 && testCase3

--------------------- VERIFICAÇÃO DOS TESTES ---------------------

main :: IO()
main = do
    putStr ("O resultado do primeiro teste foi: " ++ show testCase1)
    putStr ("O resultado do segundo teste foi: " ++ show testCase2)
    putStr ("O resultado do terceiro teste foi: " ++ show testCase3)
    putStr ("O resultado geral dos testes: " ++ show testSuite)