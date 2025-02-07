{-
QUESTÃO 11 VALOR: 1,0 ponto
    Defina a função "plantaoCorreto", cujo tipo é dado abaixo e que gera um plantão válido que satisfaz um plano de medicamentos válido e um estoque de medicamentos.

    Dica: a execução do plantão deve atender ao plano de medicamentos e ao estoque.
-}

module Questao_11.PlantaoCorreto where

import TiposDoProjeto
    ( Cuidado(..),
      EstoqueMedicamentos,
      Medicamento,
      PlanoMedicamento,
      Plantao )
import Testes ( estoque1, estoque2, plano1, plano2 )
import Questao_3.ConsultarMedicamento ( consultarMedicamento )
import Questao_1.ComprarMedicamento ( comprarMedicamento )
import Questao_10.Satisfaz ( satisfaz )

plantaoCorreto :: PlanoMedicamento -> EstoqueMedicamentos -> Plantao
plantaoCorreto [] _ = []
plantaoCorreto ((h, ms) : resto) estoque = (h, criaListaCuidado ms estoque) : plantaoCorreto resto estoque
    where
        criaListaCuidado :: [Medicamento] -> EstoqueMedicamentos -> [Cuidado]
        criaListaCuidado [] _ = []
        criaListaCuidado (m : ms) estoque
            | consultarMedicamento m estoque > 0 = Medicar m : criaListaCuidado ms estoque
            | otherwise = Comprar m 1 : criaListaCuidado (m : ms) (comprarMedicamento m 1 estoque)

main :: IO()
main = do
    let caso11_1 = plantaoCorreto plano1 estoque1
    let teste1 = satisfaz caso11_1 plano1 estoque1
    print caso11_1
    print teste1

    let caso11_2 = plantaoCorreto plano2 estoque2
    let teste2 = satisfaz caso11_2 plano2 estoque2
    print caso11_2
    print teste2

    print (teste1 && teste2)