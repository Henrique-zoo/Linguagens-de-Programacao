module Testes.TestesQ5 where

import Questoes.Q5.AbsLI
    ( Exp(EInt, EStr, ECon, EFalse, ETrue, EOr, EAnd, ENot, EAdd, ESub, EDiv, EVar),
      Ident(Ident),
      Program(Prog),
      Stm(SAss, SdoWhile, SWhile, SBlock, STry)
    )
import Questoes.Q5.Interpreter
    ( Valor(ValorInt, ValorStr, ValorBool), executeP )

-------------------------------------- Testes da Questão 1

prog1 :: Program
prog1 = Prog (SBlock [SAss (Ident "x") (EInt 1), SAss (Ident "soma") (EInt 0), SAss (Ident "c") (EInt 10), SdoWhile (SBlock [SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))), SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))]) (EVar (Ident "c"))])

{- prog1

{
    x = 1;
    soma = 0;
    c = 10;
    do {
        soma = soma + c;
        c = c - 1;
    } while (c)
}

-}

testCase1 :: Bool
testCase1 = executeP [] prog1 == Right [("x", ValorInt 1), ("soma", ValorInt 55), ("c", ValorInt 0)]

-----------------------------------------------------------------------------------------------------

prog2 :: Program
prog2 = Prog (SBlock [SAss (Ident "x") (EInt 1), SAss (Ident "soma") (EInt 0), SAss (Ident "c") (EInt 1), SdoWhile (SBlock [SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))), SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))]) (EVar (Ident "c"))])

{-

{
    x = 1;
    soma = 0;
    c = 1;
    do {
        soma = soma + c;
        c = c - 1;
    } while (c)
}

-}

testCase2 :: Bool
testCase2 = executeP [] prog2 == Right [("x", ValorInt 1), ("soma", ValorInt 1), ("c", ValorInt 0)]

------------------------------------ Fim Testes da questão 1

-------------------------------------- Testes da questão 2
prog3 :: Program
prog3 = Prog (SBlock [SAss (Ident "w") (EStr "hello"), SAss (Ident "v") (EStr "world"), SAss (Ident "a") (ECon (EVar (Ident "w")) (EVar (Ident "v")))])

{-

{
    w = "hello";
    v = "world";
    a = w ++ v;
}

-}

-- executeP :: RContext -> Program  -> RContext
testCase3 :: Bool
testCase3 = executeP [] prog3 == Right [("w", ValorStr "hello"), ("v", ValorStr "world"), ("a", ValorStr "helloworld")]

----------------------------------------------------------------------------------

prog4 :: Program
prog4 = Prog (SBlock [SAss (Ident "a") ETrue, SAss (Ident "b") EFalse, SAss (Ident "e") ETrue, SAss (Ident "d") (EOr (ENot (EVar (Ident "a"))) (EAnd (EVar (Ident "b")) (EVar (Ident "e")))), SAss (Ident "f") (EOr (EAnd (EVar (Ident "a")) (EVar (Ident "b"))) (ENot (EVar (Ident "e"))))])

{-

{
    a = true;
    b = false;
    e = true;
    d = ! a || b && e;
    f = a && b || ! e;
}

-}

testCase4 :: Bool
testCase4 = executeP [] prog4 == Right [ ("a", ValorBool True), ("b", ValorBool False), ("e", ValorBool True), ("d", ValorBool False), ("f", ValorBool False)]

------------------------------------ Fim Testes da Questão 2

-------------------------------------- Testes da Questão 3
prog5 :: Program
prog5 = Prog (SAss (Ident "x") (EInt 1))

{-
    x = 1;
-}

testCase5 :: Bool
testCase5 = executeP [] prog5 == Right [("x", ValorInt 1)]

-----------------------------------------------------------------------------------------------------------------------

prog6 :: Program
prog6 = Prog (SBlock [SAss (Ident "x") (EInt 1), SAss (Ident "soma") (EInt 0), SAss (Ident "c") (EInt 10), SWhile (EVar (Ident "c")) (SBlock [SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))), SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))])])

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

testCase6 :: Bool
testCase6 = executeP [] prog6 == Right [("x", ValorInt 1), ("soma", ValorInt 55), ("c", ValorInt 0)]

-----------------------------------------------------------------------------------------------------------------------


{--

{
    x = 1;
    y = 0;
    z = x / y;
    w = z + 1;
}

--}

prog7 :: Program
prog7 = Prog (SBlock[SAss (Ident "x") (EInt 1), SAss (Ident "y") (EInt 0), SAss (Ident "z") (EDiv (EVar (Ident "x")) (EVar (Ident "y"))), SAss (Ident "w") (EAdd (EVar (Ident "z")) (EInt 1))])

testCase7 :: Bool
testCase7 = executeP [] prog7 == Left "divisao por 0"

------------------------------------ fim Testes da Questão 3

-------------------------------------- Testes da Questão 4

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

prog8 :: Program
prog8 = Prog (SBlock[SAss (Ident "x") (EInt 1), SAss (Ident "soma") (EInt 0), SAss (Ident "c") (EInt 10), SWhile (EVar (Ident "c")) (SBlock[SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))), SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))])])

testCase8 :: Bool
testCase8 = executeP [] prog8 == Right [("x", ValorInt 1), ("soma", ValorInt 55), ("c", ValorInt 0)]

-----------------------------------------
-----------------------------------------

prog9 :: Program
prog9 = Prog (SBlock[SAss (Ident "x") (EInt 0), STry [SAss (Ident "soma") (EInt 0), SAss (Ident "c") (EDiv (EVar (Ident "x")) (EVar (Ident "soma")))] [SAss (Ident "x") (EInt 1)] [SAss (Ident "y") (EInt 2)]])

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
testCase9 :: Bool
testCase9 = executeP [] prog9 == Right [("x", ValorInt 1), ("soma", ValorInt 0), ("y", ValorInt 2)]

----------------------------------------------------------------------------------

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

prog10 :: Program
prog10 = Prog (SBlock[SAss (Ident "x") (EInt 0), STry [SAss (Ident "soma") (EInt 10), SAss (Ident "c") (EDiv (EVar (Ident "x")) (EVar (Ident "soma")))] [SAss (Ident "x") (EInt 1)] [SAss (Ident "y") (EInt 2)]])

testCase10 :: Bool
testCase10 = executeP [] prog10 == Right [("x", ValorInt 0), ("soma", ValorInt 10), ("c", ValorInt 0), ("y", ValorInt 2)]

-- uma condicao necessaria (mas nao suficiente) da implementacao eh que o valor de testSuite seja "True"
testSuite :: Bool
testSuite = and [testCase1, testCase2, testCase3, testCase4, testCase5, testCase6, testCase7, testCase8, testCase9, testCase10]