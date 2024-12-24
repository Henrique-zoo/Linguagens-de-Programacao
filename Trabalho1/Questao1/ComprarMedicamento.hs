{-
QUESTÃO 1, VALOR: 1,0 ponto
    Defina a função "comprarMedicamento", cujo tipo é dado abaixo e que, a partir de um medicamento, uma quantidade e um estoque inicial de medicamentos, retorne um novo estoque de medicamentos contendo o medicamento adicionado da referida quantidade. Se o medicamento já existir na lista de medicamentos, então a sua quantidade deve ser atualizada no novo estoque. Caso o remédio ainda não exista no estoque, o novo estoque a ser retornado deve ter o remédio e sua quantidade como cabeça.
-}

module Questao1.ComprarMedicamento where

import TiposDoProjeto
    ( EstoqueMedicamentos, Medicamento, Quantidade )
import Testes ( med1, med4, med6, med7, med9, estoque1 )

comprarMedicamento :: Medicamento -> Quantidade -> EstoqueMedicamentos -> EstoqueMedicamentos
comprarMedicamento medicamento quantidade [] = [(medicamento, quantidade)]
comprarMedicamento medicamento quantidade estoque
    | novoEstoque == estoque = (medicamento, quantidade) : estoque
    | otherwise = novoEstoque
    where
        novoEstoque = adicionarMedicamento medicamento quantidade estoque

adicionarMedicamento :: Medicamento  -> Quantidade -> EstoqueMedicamentos -> EstoqueMedicamentos
adicionarMedicamento medicamento quantidade estoque = 
    [(m, if m == medicamento then q + quantidade else q) | (m, q) <- estoque]

-- Só para testar melhor
mostrarEstoque :: EstoqueMedicamentos -> String
mostrarEstoque [] = ""
mostrarEstoque ((med, q) : resto)
    | resto == [] = "[(" ++ show med ++ ", " ++ show q ++ ")]" ++ mostrarEstoque resto
    | otherwise = "[(" ++ show med ++ ", " ++ show q ++ "); " ++ mostrarEstoque resto

main :: IO ()
main = do
    let caso1_1 = comprarMedicamento med7 30 estoque1
    putStrLn ("Caso 1: " ++ mostrarEstoque caso1_1)
    print [(med4, 10), (med6, 5), (med7, 30)]

    let caso1_2 = comprarMedicamento med1 20 estoque1
    putStrLn ("Caso 2: " ++ mostrarEstoque caso1_2)
    print [(med1, 20), (med4, 10), (med6, 5), (med7, 0)]

    let caso1_3 = comprarMedicamento med6 2 estoque1
    putStrLn ("Caso 3: " ++ mostrarEstoque caso1_3)
    print [(med4, 10), (med6, 7), (med7, 0)]

    let caso1_4 = comprarMedicamento med9 20 []
    putStrLn ("Caso 4: " ++ mostrarEstoque caso1_4)
    print [(med9, 20)]

    print (and [caso1_1 == [(med4, 10), (med6, 5), (med7, 30)], caso1_2 == [(med1, 20), (med4, 10), (med6, 5), (med7, 0)], caso1_3 == [(med4, 10), (med6, 7), (med7, 0)], caso1_4 == [(med9, 20)]])