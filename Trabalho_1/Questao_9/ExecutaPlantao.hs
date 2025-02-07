{-
QUESTÃO 9 VALOR: 1,0 ponto
    Defina a função "executaPlantao", cujo tipo é dado abaixo e que executa um plantão válido a partir de um estoque de medicamentos, resultando em novo estoque. A execução consiste em desempenhar, sequencialmente, todos os cuidados para cada horário do plantão. Caso o estoque acabe antes de terminar a execução do plantão, o resultado da função deve ser Nothing. Caso contrário, o resultado deve ser Just v, onde v é o valor final do estoque de medicamentos
-}

module Questao_9.ExecutaPlantao where

import TiposDoProjeto ( Cuidado(..), EstoqueMedicamentos, Plantao )
import Testes
    ( estoque1, estoque2, med4, med6, med7, plantao1, plantao2 )
import Questao_1.ComprarMedicamento ( comprarMedicamento )
import Questao_2.TomarMedicamento ( tomarMedicamento )

executaPlantao :: Plantao -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos
executaPlantao [] estoque = Just estoque
executaPlantao ((_, []) : resto) estoque = executaPlantao resto estoque
executaPlantao ((h, cuidado : xc) : resto) estoque = 
    case processaCuidado cuidado estoque of
        Nothing -> Nothing
        Just novoEstoque -> executaPlantao ((h, xc) : resto) novoEstoque

processaCuidado :: Cuidado -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos
processaCuidado (Comprar m q) estoque = Just (comprarMedicamento m q estoque)
processaCuidado (Medicar m) estoque = tomarMedicamento m estoque 


main :: IO()
main = do
    let caso9_1 = executaPlantao plantao1 estoque1
    let teste1 = caso9_1 == Nothing
    print caso9_1
    print teste1

    let caso9_2 = executaPlantao plantao1 estoque2
    let teste2 = caso9_2 == Just [(med4, 8), (med6, 4), (med7, 9)]
    print caso9_2
    print (Just [(med4, 8), (med6, 4), (med7, 9)])
    print teste2

    let caso9_3 = executaPlantao plantao2 estoque1
    let teste3 = caso9_3 == Just [(med4, 8), (med6, 4), (med7, 29)]
    print caso9_3
    print (Just [(med4, 8), (med6, 4), (med7, 29)])
    print teste3

    print (and [teste1, teste2, teste3])