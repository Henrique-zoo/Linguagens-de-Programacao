module Testes.TestesQ1 where

import Questoes.Q1.AbsLI
    ( Exp(EVar, EAdd, ESub, EInt),
      Stm(SAss, SdoWhile, SBlock),
      Program(Prog),
      Ident(Ident) )
import Questoes.Q1.Interpreter ( executeP )

prog1 :: Program
prog1 =
  Prog
    ( SBlock
        [ SAss (Ident "x") (EInt 1),
          SAss (Ident "soma") (EInt 0),
          SAss (Ident "c") (EInt 10),
          SdoWhile
            ( SBlock
                [ SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))),
                  SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))
                ]
            )
            (EVar (Ident "c"))
        ]
    )

{- prog1

{
  x = 1;
  soma = 0;
  c = 10;
  do {
    soma = soma + c;
    c = c - 1;
    }
  while (c)
}

-}

testCase1 :: Bool
testCase1 = executeP [] prog1 == [("x", 1), ("soma", 55), ("c", 0)]

prog2 :: Program
prog2 =
  Prog
    ( SBlock
        [ SAss (Ident "x") (EInt 1),
          SAss (Ident "soma") (EInt 0),
          SAss (Ident "c") (EInt 1),
          SdoWhile
            ( SBlock
                [ SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))),
                  SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))
                ]
            )
            (EVar (Ident "c"))
        ]
    )

{-

{
  x = 1;
  soma = 0;
  c = 1;
  do {
    soma = soma + c;
    c = c - 1;
    }
  while (c)
}

-}

testCase2 :: Bool
testCase2 = executeP [] prog2 == [("x", 1), ("soma", 1), ("c", 0)]

-- uma condicao necessaria (mas nao suficiente) da implementacao eh que o valor de testSuite seja "True"
testSuite :: Bool
testSuite = testCase1 && testCase2

-- note que o programa abaixo entra em loop infinito, conforme esperado
-- "executeP [] prog3" entra em loop.
prog3 :: Program
prog3 =
  Prog
    ( SBlock
        [ SAss (Ident "x") (EInt 1),
          SAss (Ident "soma") (EInt 0),
          SAss (Ident "c") (EInt 0),
          SdoWhile
            ( SBlock
                [ SAss (Ident "soma") (EAdd (EVar (Ident "soma")) (EVar (Ident "c"))),
                  SAss (Ident "c") (ESub (EVar (Ident "c")) (EInt 1))
                ]
            )
            (EVar (Ident "c"))
        ]
    )

{-
{
  x = 1;
  soma = 0;
  c = 0;
  do {
    soma = soma + c;
    c = c - 1;
    }
  while (c)
}

-}

--------------------- VERIFICAÇÃO DOS TESTES ---------------------
main :: IO()
main = do
    print testCase1
    print testCase2
    print "O caso 3 entra num loop infinito, portanto não pode ser testado aqui"