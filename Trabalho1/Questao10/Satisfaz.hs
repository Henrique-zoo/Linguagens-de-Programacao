{-
QUESTÃO 10 VALOR: 1,0 ponto
    Defina uma função "satisfaz", cujo tipo é dado abaixo e que verifica se um plantão válido satisfaz um plano de medicamento válido para um certo estoque, ou seja, a função "satisfaz" deve verificar se a execução do plantão implica terminar com estoque diferente de Nothing e administrar os medicamentos prescritos no plano.
    
    Dica: fazer correspondencia entre os remédios previstos no plano e os ministrados pela execução do plantão. Note que alguns cuidados podem ser comprar medicamento e que eles podem ocorrer sozinhos em certo horário ou juntamente com ministrar medicamento.
-}

module Questao10.Satisfaz where

import TiposDoProjeto
    ( Cuidado(Medicar),
      EstoqueMedicamentos,
      PlanoMedicamento,
      Plantao )
import Testes ( estoque1, estoque2, plano1, plantao1, plantao2 )
import Questao9.ExecutaPlantao ( executaPlantao )

satisfaz :: Plantao -> PlanoMedicamento -> EstoqueMedicamentos -> Bool
satisfaz plantao planoMedicamento estoque = executa && corresponde plantao planoMedicamento
    where
        executa = case executaPlantao plantao estoque of
            Nothing      -> False
            Just estoque -> True
        corresponde :: Plantao -> PlanoMedicamento -> Bool
        corresponde [] [] = True
        corresponde _ [] = False
        corresponde [] _ = False
        corresponde ((h, lC) : ps) ((h', lM) : pls)
            | h == h' && lM == [m | Medicar m <- lC] = corresponde ps pls

main :: IO()
main = do
    let caso10_1 = satisfaz plantao1 plano1 estoque1
    let caso10_2 = satisfaz plantao1 plano1 estoque2
    let caso10_3 = satisfaz plantao2 plano1 estoque1

    print caso10_1
    print caso10_2
    print caso10_3
    print (not caso10_1 && caso10_2 && caso10_3)